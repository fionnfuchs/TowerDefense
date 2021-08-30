extends Node2D



func _ready():
	Signals.connect("wave_beaten", self, "on_wave_beaten")
	
func on_wave_beaten(wave_number):
	if wave_number == 5:
		var gold_chest_instance = Scenes.gold_chest.instance()
		gold_chest_instance.position = Vector2(8,-104)
		self.get_parent().add_child(gold_chest_instance)
