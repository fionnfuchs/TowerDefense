extends Control

var simple_tower = preload("res://scenes/Towers/SimpleTower.tscn")
var house = preload("res://scenes/Buildings/House.tscn")

onready var tower_wood_label = $Tower/WoodLabel
onready var tower_stone_label = $Tower/StoneLabel
onready var tower_build_button = $Tower/Button

onready var house_gold_label = $House/GoldLabel
onready var house_build_button = $House/Button
onready var house_help_button = $House/HelpButton

onready var current_tower_price = calculate_tower_prices()
onready var current_house_price = calculate_house_prices()

func _ready():
	Entities.build_menu = self
	tower_build_button.connect("button_up", self, "build_tower")
	house_build_button.connect("button_up", self, "build_house")
	house_help_button.connect("button_up", self, "house_help")

func _process(delta):
	
	if GameState.interaction_mode == 1:
		self.visible = true
	else:
		self.visible = false
	
	update_ui()

func update_ui():
	current_tower_price = calculate_tower_prices()
	tower_wood_label.text = str(current_tower_price["wood"])
	tower_stone_label.text = str(current_tower_price["stone"])
	
	house_gold_label.text = str(current_house_price["gold"])
	
	
	if Resources.resources["wood"] >= current_tower_price["wood"] && Resources.resources["stone"] >= current_tower_price["stone"]:
		tower_build_button.disabled = false
		
		tower_wood_label.self_modulate = Color(1.0,1.0,1.0)
		tower_stone_label.self_modulate = Color(1.0,1.0,1.0)
	else: # Disable button if not enough resources
		tower_build_button.disabled = true
		
		# Color resource icons red when not enough of the resource
		if Resources.resources["wood"] < current_tower_price["wood"]:
			tower_wood_label.self_modulate = Color(1.0,0.2,0.2)
		else:
			tower_wood_label.self_modulate = Color(1.0,1.0,1.0)
		if Resources.resources["stone"] < current_tower_price["stone"]:
			tower_stone_label.self_modulate = Color(1.0,0.2,0.2)
		else:
			tower_stone_label.self_modulate = Color(1.0,1.0,1.0)
	
	if Resources.resources["gold"] >= current_house_price["gold"]:
		house_build_button.disabled = false
	else:
		house_build_button.disabled = true
		house_gold_label.self_modulate = Color(1.0,0.2,0.2)

func build_tower():
	if Resources.resources["wood"] >= current_tower_price["wood"] && Resources.resources["stone"] >= current_tower_price["stone"]:
		Signals.emit_signal("trigger_build", simple_tower)

func build_house():
	if Resources.resources["gold"] >= current_house_price["gold"]:
		Signals.emit_signal("trigger_build", house)

func house_help():
	Entities.tutorial_menu.tutorial_state = 901

func calculate_tower_prices():
	return {
		"wood": Prices.simple_tower["wood"] + GameState.active_towers * Prices.simple_tower["wood_increment"],
		"stone": Prices.simple_tower["stone"] + GameState.active_towers * Prices.simple_tower["stone_increment"]
	}
	
func calculate_house_prices():
	return {
		"gold": 50,
	}
