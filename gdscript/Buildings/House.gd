extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var area2d = $Area2D

var grid_vector = Vector2()
onready var build_sound = get_node("BuildSound")

var resources_in_area = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	GameState.active_houses += 1
	update_grid()
	
	area2d.connect("body_entered", self, "body_entered_area")
	area2d.connect("body_exited", self, "body_exited_area")
	
	Signals.connect("after_wave_beaten", self, "collect_resources")
	
func update_grid():
	var new_grid_vector = Grid.get_grid_position(position)
	Grid.set_grid_value(grid_vector, 0)
	Grid.set_grid_value(new_grid_vector, 1)
	grid_vector = new_grid_vector

func play_build_sound():
	build_sound.play()
	
func collect_resources():
	for resource in resources_in_area:
		resource.interact(true)

func body_entered_area(body):
	if body.has_node("Resource"):
		resources_in_area.append(body)

func body_exited_area(body):
	if body.has_node("Resource"):
		resources_in_area.erase(body)

