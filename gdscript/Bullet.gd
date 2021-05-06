extends Node2D

export(int) var movement_speed = 500
export(int) var damage = 1

var target = null
var active = false
var type = "NORMAL"

func _ready():
	pass # Replace with function body.

func _process(delta):
	if active:
		if target != null:
			var direction = target.position - self.position
			if direction.length() < 6:
				hit_target()
			else:
				self.position += direction.normalized() * movement_speed * delta
		else:
			queue_free()

func hit_target():
	if target.has_method("get_hit"):
		target.get_hit(self.damage)
	else:
		print("WARNING: Target not hitable.")
	if type == "SLOWDOWN" and target.has_method("set_buff"):
		target.set_buff("SLOWDOWN")
	queue_free()
