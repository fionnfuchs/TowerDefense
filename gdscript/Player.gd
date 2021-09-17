extends KinematicBody2D

var movement_speed = 55
var look_direction = 1

onready var graphics_sprite = get_node("Sprite")
onready var build_cursor = get_node("BuildCursor")
onready var interaction_cursor = get_node("InteractionCursor")
onready var interaction_radius = get_node("InteractionRadius")
onready var collision_shape = get_node("CollisionShape2D")
onready var parent = get_parent()
onready var animation_player = get_node("AnimationPlayer")

onready var carried_item_sprite = get_node("CarriedItem")

onready var interaction_charge_background = get_node("InteractionChargeBackground")
onready var interaction_charge_bar = get_node("InteractionChargeBar")

var interaction_target = null
var interactables = []
var interaction_charge = 0
var interaction_charge_needed = 0.3
var interaction_locked = false

var carried_item = 0

func _ready():
	interaction_radius.connect("body_entered", self, "body_entered_interaction_radius")
	interaction_radius.connect("body_exited", self, "body_exited_interaction_radius")
	
	Signals.connect("trigger_build", self, "build")
	Entities.player = self
	
	graphics_sprite.scale.x = -1

func _process(delta):
	process_interaction(delta)
	if GameState.game_state < 2:
		process_movement(delta)
		if GameState.game_state == 0:
			process_input(delta)
			process_interactables()
			process_cursor()
			self.visible = true
			collision_shape.disabled = false
			
			Difficulty.raise_difficulty(delta)
		else:
			self.visible = false
			collision_shape.disabled = true
	
	if carried_item != 0:
		carried_item_sprite.visible = true
	else:
		carried_item_sprite.visible = false

func set_carried_item(item_id):
	carried_item = item_id
	carried_item_sprite.texture = Items.get_item_icon(item_id)

func process_movement(delta):
	var move_direction = Vector2(0,0)

	if Input.is_action_pressed("ui_up"):
		move_direction.y = -1
	if Input.is_action_pressed("ui_down"):
		move_direction.y = 1
	if Input.is_action_pressed("ui_left"):
		if look_direction == 1:
			graphics_sprite.scale.x = 1
			look_direction = -1
		move_direction.x = -1
	if Input.is_action_pressed("ui_right"):
		if look_direction == -1:
			graphics_sprite.scale.x = -1
			look_direction = 1
		move_direction.x = 1
	
	if move_direction != Vector2(0,0):
		animation_player.current_animation = "Walk"
	else:
		animation_player.current_animation = "Idle"
	
	self.move_and_slide(move_direction.normalized() * movement_speed * delta * 100)
	
func process_input(delta):
	if Input.is_action_just_pressed("toggle_build_mode"):
		if GameState.interaction_mode == 1:
			GameState.set_interaction_mode(0)
		else:
			GameState.set_interaction_mode(1)

func process_interaction(delta):
	if GameState.interaction_mode == 0 and interaction_target != null:
		if Input.is_action_pressed("interact") and !interaction_locked:
			interaction_charge_background.visible = true
			interaction_charge_bar.visible = true
			
			interaction_charge_bar.scale.x = interaction_charge / interaction_charge_needed
			interaction_charge_bar.position.x = (1 - float(interaction_charge) / interaction_charge_needed) * -8
			
			interaction_charge += delta
			if interaction_charge > interaction_charge_needed:
				if interaction_target.has_method("interact"):
					interaction_target.interact()
					interaction_locked = true
				else:
					print("WARNING: Unimplemented Interactable")
				interaction_charge = 0
		else:
			interaction_charge_background.visible = false
			interaction_charge_bar.visible = false
			interaction_charge = 0
	else:
		interaction_charge_background.visible = false
		interaction_charge_bar.visible = false
		interaction_charge = 0
	if Input.is_action_just_released("interact"):
		interaction_locked = false

func process_cursor():
	if GameState.interaction_mode == 1:
		build_cursor.visible = true
		interaction_cursor.visible = false
		var grid_vector = Grid.get_grid_position(position)
		build_cursor.global_position = Grid.grid_to_world_position(grid_vector)
			
	else:
		build_cursor.visible = false
		if interaction_target != null:
			interaction_cursor.visible = true
			interaction_cursor.global_position = Vector2(interaction_target.position.x, interaction_target.position.y - 14)
		else:
			interaction_cursor.visible = false

func process_interactables():
	var old_interaction_target = interaction_target
	interaction_target = null
	
	for interactable in interactables:
		if interaction_target == null:
			interaction_target = interactable
		elif interaction_target.position.distance_to(self.position) > interactable.position.distance_to(self.position):
			interaction_target = interactable
	
	if interaction_target != null and interaction_target != old_interaction_target:
		Signals.emit_signal("interaction_target_changed", interaction_target)
			
func body_entered_interaction_radius(body):
	if(body.has_node("Interactable")):
		interactables.append(body)

func body_exited_interaction_radius(body):
	if(body.has_node("Interactable")):
		interactables.erase(body)

func build(building):
	var grid_vector = Grid.get_grid_position(position)
	if Grid.get_grid_value(grid_vector) == 0 and Entities.path_tiles.is_free_position(position.x, position.y):
		Resources.resources["wood"] -= Entities.build_menu.current_tower_price["wood"]
		Resources.resources["stone"] -= Entities.build_menu.current_tower_price["stone"]
		
		var building_instance = building.instance()
		parent.add_child(building_instance)
		building_instance.global_position = Grid.grid_to_world_position(grid_vector)
		building_instance.update_grid()
		building_instance.play_build_sound()
	else:
		print("Place already taken...")
	
