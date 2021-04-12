extends Panel


onready var label = get_node("Label")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var resource_text = "Wood: " + str(Resources.resources["wood"]) + "\n"
	resource_text += "Stone: " + str(Resources.resources["stone"]) + "\n"
	resource_text += "Gold: " + str(Resources.resources["gold"]) + "\n"
	label.text = resource_text
