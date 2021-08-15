extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var grid_vector = Vector2()
onready var build_sound = get_node("BuildSound")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	GameState.active_houses += 1
	update_grid()
	
func update_grid():
	var new_grid_vector = Grid.get_grid_position(position)
	Grid.set_grid_value(grid_vector, 0)
	Grid.set_grid_value(new_grid_vector, 1)
	grid_vector = new_grid_vector

func play_build_sound():
	build_sound.play()
