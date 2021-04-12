extends StaticBody2D

export(String) var resource_name = "Resource"

func _ready():
	position_changed()
	
func position_changed():
	Grid.set_grid_value_by_world_position(self.position, 2)

func interact():
	Resources.resources[resource_name] += 1
