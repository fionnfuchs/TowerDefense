extends Panel

onready var score_label = $ScoreLabel
onready var new_highscore_label = $NewHighscoreLabel
onready var back_button = $BackToMenuButton

var highscore_set = false

# Called when the node enters the scene tree for the first time.
func _ready():
	back_button.connect("button_up", self, "back_to_menu")
	highscore_set = false

func _process(delta):
	if GameState.game_state == 9999:
		self.visible = true
		
		score_label.text = "Your score: " + str(Difficulty.current_wave - 1) + " waves survived"
		
		if Difficulty.current_wave - 1 > Persistence.highscore:
			Persistence.highscore = Difficulty.current_wave - 1
			highscore_set = true
			
		if highscore_set:
			new_highscore_label.visible = true
		else:
			new_highscore_label.visible = false
		
	else:
		self.visible = false

func back_to_menu():
	get_tree().change_scene("res://scenes/RootScenes/MainMenu.tscn")
