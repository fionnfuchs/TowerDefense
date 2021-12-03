extends Node

var game_state = 0 # 0 = Player Visible Walking State, 1 = Wave incoming, 2 = Druid Menu, 3 = Item Shop, 4 = Tutorial, 5 = Skill Menu, 9999 = Lost
var interaction_mode = 0

var active_towers = 0
var active_houses = 0

var items_bought = 0

var time_speed = 1

signal game_state_changed(new_state)
signal interaction_mode_changed(new_mode)

func _ready():
	pass

func set_interaction_mode(new_mode):
	self.interaction_mode = new_mode
	emit_signal("interaction_mode_changed", new_mode)

func set_game_state(new_state):
	self.game_state = new_state
	emit_signal("game_state_changed", new_state)

func reset():
	game_state = 0
	interaction_mode = 0
	active_towers = 0
	items_bought = 0
	time_speed = 1
