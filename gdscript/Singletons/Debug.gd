extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Debug Mode Enabled")

func _process(delta):
	if Input.is_action_just_pressed("Cheat"):
		Resources.resources["wood"] += 10
		Resources.resources["stone"] += 10
		print("Cheated Resources")
