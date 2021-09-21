extends Panel

onready var play_button = $Button
onready var highscore_label = $Label

func _ready():
	Grid.reset()
	Difficulty.reset()
	Entities.reset()
	GameState.reset()
	GlobalEffects.reset()
	Resources.reset()
	
	play_button.connect("button_up", self, "start_demo")

func _process(delta):
	highscore_label.text = "Highscore: " + str(Persistence.highscore) + " waves survived"

func start_demo():
	get_tree().change_scene("res://scenes/PrototypeDefault.tscn")
