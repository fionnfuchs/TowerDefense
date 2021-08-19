extends Control

onready var categories_node = get_node("Categories")
onready var towers_node = get_node("Towers")

onready var basic_tower_node = get_node("Towers/Basic Tower")

onready var supply_node = get_node("Supply")
onready var house_wood_label = get_node("Supply/House/Label2")
onready var house_stone_label = get_node("Supply/House/Label3")

var menu_state = "categories"


# TODO: REFACTOR THIS MESS AFTER THE MVP

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
		
		
		basic_tower_node.get_node("Wood").text = str(Prices.simple_tower.wood + GameState.active_towers * Prices.simple_tower.wood_increment)
		basic_tower_node.get_node("Stone").text = str(Prices.simple_tower.stone + GameState.active_towers * Prices.simple_tower.stone_increment)
		
	elif menu_state == "supply":
		house_wood_label.text = str(Prices.house.wood + GameState.active_houses * Prices.house.wood_increment)
		house_stone_label.text = str(Prices.house.stone + GameState.active_houses * Prices.house.stone_increment)
		supply_node.visible = true
		
func check_keyboard_input():
	if menu_state == "categories":
		if Input.is_action_just_pressed("1"):
			menu_state = "towers"
		if Input.is_action_just_pressed("2"):
			menu_state = "supply"
	elif menu_state == "towers":
		if Input.is_action_just_pressed("1"):
			if Resources.resources["wood"] >= (Prices.simple_tower.wood + GameState.active_towers * Prices.simple_tower.wood_increment) and Resources.resources["stone"] >= (Prices.simple_tower.stone + GameState.active_towers * Prices.simple_tower.stone_increment):
				# CHECK SIGNAL BEFORE
				Resources.resources["wood"] -= (Prices.simple_tower.wood + GameState.active_towers * Prices.simple_tower.wood_increment)
				Resources.resources["stone"] -= (Prices.simple_tower.stone + GameState.active_towers * Prices.simple_tower.stone_increment)
				Signals.emit_signal("trigger_build", Scenes.simple_tower)
		elif Input.is_action_just_pressed("0"):
			menu_state = "categories"
	elif menu_state == "supply":
		if Input.is_action_just_pressed("1"):
			if Resources.resources["wood"] >= (Prices.house.wood + GameState.active_houses * Prices.house.wood_increment) and Resources.resources["stone"] >= (Prices.house.stone + GameState.active_houses * Prices.house.stone_increment):
				# CHECK SIGNAL BEFORE
				Resources.resources["wood"] -= (Prices.house.wood + GameState.active_houses * Prices.house.wood_increment)
				Resources.resources["stone"] -= (Prices.house.stone + GameState.active_houses * Prices.house.stone_increment)
				Signals.emit_signal("trigger_build", Scenes.building_house)
		elif Input.is_action_just_pressed("0"):
			menu_state = "categories"
