extends Panel


onready var difficulty_label = get_node("Label")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	difficulty_label.text = "Difficulty: " + str(round(Difficulty.difficulty * 10) / 10)
