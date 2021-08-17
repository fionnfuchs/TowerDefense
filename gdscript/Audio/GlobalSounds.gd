extends Node2D


func _ready():
	Signals.connect("play_global_sound", self, "play_sound")

func _process(delta):
	position = Entities.player.position


func play_sound(sound_name):
	print("Playing Sound " + sound_name)
	get_node(sound_name).play()
