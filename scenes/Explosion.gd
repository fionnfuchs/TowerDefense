extends Sprite

onready var timer = $Timer
onready var damage_timer = $DamageTimer
onready var damage_area = $Area2D

var damage = 0.5

func _ready():
	timer.connect("timeout", self, "destroy")
	damage_timer.connect("timeout", self, "apply_damage")

func apply_damage():
	var overlapping_bodies = damage_area.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.has_method("get_hit"):
			body.get_hit(damage)

func destroy():
	queue_free()
