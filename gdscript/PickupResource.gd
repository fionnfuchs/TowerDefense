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
	if resource_name == "gold":
		Signals.emit_signal("play_global_sound", "CollectCoin")
		Signals.emit_signal("gold_updated")
	if resource_name == "crystal":
		Signals.emit_signal("crystal_updated")
	queue_free()
