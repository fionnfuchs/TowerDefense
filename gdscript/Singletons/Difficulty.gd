extends Node

var difficulty = 1.0
var current_wave = 1

func _ready():
	pass

func raise_difficulty(delta):
	difficulty += 0.02 * delta

func reset():
	difficulty = 1.0
	current_wave = 1
