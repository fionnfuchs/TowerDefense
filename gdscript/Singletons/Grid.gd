extends Node

var grid = []

var width = 128
var height = 128

var cell_size = 16

func _ready():
	init_grid()

func get_grid_position(world_position):
	var grid_position = Vector2(0,0)
	# Adjust world position so that the grid has its midpoint in (0,0)
	var world_adjusted_x = world_position.x + (width * cell_size) / 2 
	var world_adjusted_y = world_position.y + (height * cell_size) / 2
	
	grid_position.x = floor(world_adjusted_x / cell_size)
	grid_position.y = floor(world_adjusted_y / cell_size)
	
	return grid_position

func get_grid_value_by_world_position(world_position):
	var grid_position = get_grid_position(world_position)
	print(grid_position)
	
	# Check if grid covers world position
	if grid_position.x >= width or grid_position.y >= height or grid_position.x < 0 or grid_position.y < 0:
		return -1
	
	return grid[grid_position.x][grid_position.y]

func get_grid_value(grid_position):
	if grid_position.x >= width or grid_position.y >= height or grid_position.x < 0 or grid_position.y < 0:
		return -1
	
	return grid[grid_position.x][grid_position.y]

func set_grid_value(grid_position, value):
	if grid_position.x >= width or grid_position.y >= height or grid_position.x < 0 or grid_position.y < 0:
		return -1
	
	grid[grid_position.x][grid_position.y] = value

func grid_to_world_position(grid_position):
	grid_position = grid_position * cell_size
	var grid_adjusted_x = grid_position.x - (width * cell_size) / 2 + 8
	var grid_adjusted_y = grid_position.y - (height * cell_size) / 2 + 8
	
	return Vector2(grid_adjusted_x, grid_adjusted_y)

func set_grid_value_by_world_position(world_position, value):
	var grid_position = get_grid_position(world_position)
	# Check if grid covers world position
	if grid_position.x >= width or grid_position.y >= height or grid_position.x < 0 or grid_position.y < 0:
		return -1
	
	grid[grid_position.x][grid_position.y] = value

func init_grid():
	for y in range(height):
		var row = []
		for x in range(width):
			row.append(0)
		grid.append(row)
	
func reset():
	init_grid()
