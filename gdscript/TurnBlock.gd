extends Area2D

export(int) var turn_direction = 1

func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	if "Enemy" in body.name:
		if body.has_method("turn"):
			body.turn(turn_direction)
