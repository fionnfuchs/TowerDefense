extends Panel


onready var difficulty_label = get_node("Label")
onready var wave_text = $WaveText

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	difficulty_label.text = "Difficulty: " + str(round(Difficulty.difficulty * 10) / 10)
	if GameState.game_state == 0 or GameState.game_state == 2:
		wave_text.text = "Wave " + str(Difficulty.current_wave) + " waiting"
	elif GameState.game_state == 1:
		wave_text.text = "Wave " + str(Difficulty.current_wave-1) + " incoming"
