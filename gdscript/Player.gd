extends KinematicBody2D

signal interaction_target_changed(new_target)

var movement_speed = 50
var look_direction = 1

onready var graphics_sprite = get_node("Sprite")
onready var build_cursor = get_node("BuildCursor")
onready var interaction_cursor = get_node("InteractionCursor")
onready var interaction_radius = get_node("InteractionRadius")

var interaction_target = null
var interactables = []

func _ready():
	interaction_radius.connect("body_entered", self, "body_entered_interaction_radius")
	interaction_radius.connect("body_exited", self, "body_exited_interaction_radius")

func _process(delta):
	process_movement(delta)
	process_interactables()
	process_input()
	process_cursor()
	

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
	
	if Input.is_action_just_pressed("ui_accept"):
		#print(Grid.get_grid_value_by_world_position(self.position))
		print(interaction_target)
	
	self.move_and_slide(move_direction.normalized() * movement_speed * delta * 100)
	
func process_input():
	if Input.is_action_just_pressed("toggle_build_mode"):
		if GameState.interaction_mode == 1:
			GameState.set_interaction_mode(0)
		else:
			GameState.set_interaction_mode(1)
	if GameState.interaction_mode == 0 and interaction_target != null:
		if Input.is_action_just_pressed("interact"):
			if interaction_target.has_method("interact"):
				interaction_target.interact()
			else:
				print("WARNING: Unimplemented Interactable")
	

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
		emit_signal("interaction_target_changed", interaction_target)
			
func body_entered_interaction_radius(body):
	if(body.has_node("Interactable")):
		interactables.append(body)

func body_exited_interaction_radius(body):
	if(body.has_node("Interactable")):
		interactables.erase(body)
