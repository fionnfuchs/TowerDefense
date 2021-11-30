extends Control


onready var label = get_node("Label")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var resource_text = str(Resources.resources["wood"]) + "\n\n"
	resource_text += str(Resources.resources["stone"]) + "\n\n"
	resource_text += str(Resources.resources["gold"]) + "\n\n"
	resource_text += str(Resources.resources["crystal"]) + "\n"
	label.text = resource_text
