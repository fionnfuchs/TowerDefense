extends Node

var game_state = 0
var interaction_mode = 0

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
