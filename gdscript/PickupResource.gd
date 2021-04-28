extends Area2D

export(String) var resource_name = "gold"
export(int) var amount = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered", self, "body_entered")

func body_entered(body):
	if body.name == "Player":
		pick_up()

func pick_up():
	Resources.resources[resource_name] += amount
	queue_free()
