extends StaticBody2D

var grid_position = Vector2()

onready var exclamation_symbol = $ExclamationSymbol

func _ready():
	position_changed()

func _process(delta):
	if Resources.resources["gold"] < 25:
		exclamation_symbol.visible = false
	else:
		exclamation_symbol.visible = true

func position_changed():
	grid_position = Grid.get_grid_position(self.position)
	Grid.set_grid_value_by_world_position(grid_position, 0)
	Grid.set_grid_value_by_world_position(self.position, 2)

func interact():
	GameState.set_game_state(2)
	pass

func get_info_text():
	return "Hold F to talk to the Druid"
