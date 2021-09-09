extends StaticBody2D

onready var exclamation_symbol = $ExclamationSymbol

func _ready():
	Entities.item_shop = self
	exclamation_symbol.visible = false

func interact():
	GameState.set_game_state(3)

func get_info_text():
	return "Hold F to talk to the shopkeeper"
