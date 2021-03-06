extends Node2D

var possible_positions = [Vector2(8,-104),Vector2(152,104),Vector2(-152,104),Vector2(8,152),Vector2(8,-152)]


func _ready():
	Signals.connect("wave_beaten", self, "on_wave_beaten")
	
func on_wave_beaten(wave_number):
	if wave_number%5 == 0:
		var gold_chest_instance = Scenes.gold_chest.instance()
		gold_chest_instance.position = possible_positions[int(rand_range(0,len(possible_positions)))]
		self.get_parent().add_child(gold_chest_instance)
		Entities.notification_panel.queue_notification("A treasure chest has appeared somewhere on the map!", Scenes.chest_texture)
