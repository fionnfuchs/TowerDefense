extends Control

onready var categories_node = get_node("Categories")
onready var towers_node = get_node("Towers")
onready var towers_wood_label = get_node("Towers/Basic Tower/Label2")
onready var towers_stone_label = get_node("Towers/Basic Tower/Label3")

var menu_state = "categories"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	
	if GameState.interaction_mode == 1:
		self.visible = true
		update_menu_state()
		check_keyboard_input()
	else:
		self.visible = false
	
	if Input.is_action_just_pressed("toggle_build_mode"):
		menu_state = "categories"

func update_menu_state():
	categories_node.visible = false
	towers_node.visible = false
	
	if menu_state == "categories":
		categories_node.visible = true
	elif menu_state == "towers":
		towers_node.visible = true
		towers_wood_label.text = str(3 + GameState.active_towers)
		towers_stone_label.text = str(3 + GameState.active_towers)
		
func check_keyboard_input():
	if menu_state == "categories":
		if Input.is_action_just_pressed("1"):
			menu_state = "towers"
	elif menu_state == "towers":
		if Input.is_action_just_pressed("1"):
			if Resources.resources["wood"] >= (3 + GameState.active_towers) and Resources.resources["stone"] >= (3 + GameState.active_towers):
				# CHECK SIGNAL BEFORE
				Resources.resources["wood"] -= (3 + GameState.active_towers)
				Resources.resources["stone"] -= (3 + GameState.active_towers)
				Signals.emit_signal("trigger_build", Scenes.simple_tower)
		elif Input.is_action_just_pressed("0"):
			menu_state = "categories"
