extends Control

func _ready():
	pass # Replace with function body.

func _process(delta):
	if GameState.interaction_mode == 0:
		self.visible = true
	else:
		self.visible = false
