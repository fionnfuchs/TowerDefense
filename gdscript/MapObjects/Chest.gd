extends StaticBody2D

export(String) var drops = "GOLD"

func _ready():
	pass

func interact():
	for i in range(rand_range(5,20)):
		var r = rand_range(0,100)
		var pickup = Scenes.gold_pickup.instance()
		if r < 50:
			pickup = Scenes.crystal_pickup.instance()
		pickup.position.x = position.x - 20 + rand_range(0,40)
		pickup.position.y = position.y - 20 + rand_range(0,40)
		self.get_parent().add_child(pickup)
	
	queue_free()

func get_info_text():
	return "Hold F to open chest"
