extends Control

onready var categories_node = get_node("Categories")
onready var towers_node = get_node("Towers")

onready var basic_tower_node = get_node("Towers/Basic Tower")
onready var slowdown_tower_node = get_node("Towers/Slowdown Tower")

onready var supply_node = get_node("Supply")
onready var house_wood_label = get_node("Supply/House/Label2")
onready var house_stone_label = get_node("Supply/House/Label3")

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
	supply_node.visible = false
	
	if menu_state == "categories":
		categories_node.visible = true
	elif menu_state == "towers":
		towers_node.visible = true
		
		
		basic_tower_node.get_node("Wood").text = str(3 + GameState.active_towers * 2)
		basic_tower_node.get_node("Stone").text = str(3 + GameState.active_towers * 2)
		
		slowdown_tower_node.get_node("Wood").text = str(3 + GameState.active_towers * 2)
		slowdown_tower_node.get_node("Stone").text = str(3 + GameState.active_towers * 2)
		
	elif menu_state == "supply":
		house_wood_label.text = str(3 + GameState.active_towers)
		house_stone_label.text = str(3 + GameState.active_towers)
		supply_node.visible = true
		
func check_keyboard_input():
	if menu_state == "categories":
		if Input.is_action_just_pressed("1"):
			menu_state = "towers"
		if Input.is_action_just_pressed("2"):
			menu_state = "supply"
	elif menu_state == "towers":
		if Input.is_action_just_pressed("1"):
			if Resources.resources["wood"] >= (3 + GameState.active_towers * 2) and Resources.resources["stone"] >= (3 + GameState.active_towers * 2):
				# CHECK SIGNAL BEFORE
				Resources.resources["wood"] -= (3 + GameState.active_towers * 2)
				Resources.resources["stone"] -= (3 + GameState.active_towers * 2)
				Signals.emit_signal("trigger_build", Scenes.simple_tower)
		if Input.is_action_just_pressed("2"):
			if Resources.resources["wood"] >= (3 + GameState.active_towers * 2) and Resources.resources["stone"] >= (3 + GameState.active_towers * 2):
				# CHECK SIGNAL BEFORE
				Resources.resources["wood"] -= (3 + GameState.active_towers * 2)
				Resources.resources["stone"] -= (3 + GameState.active_towers * 2)
				Signals.emit_signal("trigger_build", Scenes.slowdown_tower)
		elif Input.is_action_just_pressed("0"):
			menu_state = "categories"
	elif menu_state == "supply":
		if Input.is_action_just_pressed("1"):
			if Resources.resources["wood"] >= (3 + GameState.active_houses) and Resources.resources["stone"] >= (3 + GameState.active_houses):
				# CHECK SIGNAL BEFORE
				Resources.resources["wood"] -= (3 + GameState.active_houses)
				Resources.resources["stone"] -= (3 + GameState.active_houses)
				Signals.emit_signal("trigger_build", Scenes.building_house)
		elif Input.is_action_just_pressed("0"):
			menu_state = "categories"
