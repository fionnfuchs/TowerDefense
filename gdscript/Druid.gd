extends StaticBody2D

var grid_position = Vector2()

func _ready():
	position_changed()

func position_changed():
	grid_position = Grid.get_grid_position(self.position)
	Grid.set_grid_value_by_world_position(grid_position, 0)
	Grid.set_grid_value_by_world_position(self.position, 2)

func interact():
	pass

func get_info_text():
	return "Hold F to talk to the Druid"
