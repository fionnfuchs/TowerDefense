extends Sprite

onready var timer = $Timer

func _ready():
	timer.connect("timeout", self, "destroy")


func destroy():
	queue_free()
