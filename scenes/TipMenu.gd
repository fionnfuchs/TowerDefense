extends Panel

var tutorial_state = 0

var tutorial_messages = ["Welcome! This is a quick tutorial. It will not take long I promise! First you need to collect some resources. Go to the trees and stones around here and hold F to collect them.",
							"Very good! Now you can build a tower. Go where you want to build it and press B to access the build menu. Then select the tower to build it. You can see a white square which indicates where the tower will be placed.",
							"Excellent! Notice that while you have been doing all of this the difficulty value on the top right has been rising slowly. Do not worry too much about this right now but keep in mind that while you are collecting and building the difficulty constantly rises.",
							"You can now start the first wave of enemies by going to the castle in the middle of the map where the path ends and holding F. You will be able to control the camera while the enemies are approaching but you can not build or collect resources.",
							"Thats it. The rest is up to you. Make sure you visit the druids on the map sometime to see what they have to offer. In general you can interact with most things by holding F."]

onready var tutorial_label = $TutorialLabel
onready var tutorial_text = $TutorialText
onready var understood_button = $UnderstoodButton

var game_state_before = 0

func _ready():
	understood_button.connect("button_up", self, "understood")

func _process(delta):
	process_tutorial(delta)
	
	if GameState.game_state == 4:
		self.visible = true
		if Input.is_action_just_pressed("space"):
			understood()
	else:
		self.visible = false
	
	
	
func process_tutorial(delta):
	if tutorial_state == 0:
		show_current_tutorial_message()
	if tutorial_state == 1:
		if Resources.resources["wood"] >= 4 and Resources.resources["stone"] >= 4:
			show_current_tutorial_message()
	if tutorial_state == 2:
		if GameState.active_towers > 0:
			show_current_tutorial_message()
	if tutorial_state == 3:
		show_current_tutorial_message()
	if tutorial_state == 4:
		if GameState.game_state == 1:
			show_current_tutorial_message()

func show_current_tutorial_message():
	GameState.interaction_mode = 0
	if GameState.game_state != 4:
		game_state_before = GameState.game_state
	else:
		game_state_before = 0
	GameState.set_game_state(4)
	tutorial_text.text = tutorial_messages[tutorial_state]

func understood():
	if GameState.game_state == 4:
		GameState.set_game_state(game_state_before)
		tutorial_state += 1
	
