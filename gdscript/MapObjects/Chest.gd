extends StaticBody2D

export(String) var drops = "GOLD"

func _ready():
	pass

func interact():
	for i in range(rand_range(5,15)):
		var gold_pickup = Scenes.gold_pickup.instance()
		gold_pickup.position.x = position.x - 16 + rand_range(0,32)
		gold_pickup.position.y = position.y - 16 + rand_range(0,32)
		self.get_parent().add_child(gold_pickup)
		
	
	queue_free()

func get_info_text():
	return "Hold F to open chest"
