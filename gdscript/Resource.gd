extends StaticBody2D

export(String) var resource_name = "Resource"

onready var sprite = get_node("Sprite")
onready var gather_sound = get_node("GatherSound")

var grid_position = Vector2()
var max_amount = 1
var current_amount = 1

func _ready():
	print(gather_sound)
	position_changed()
	
	Signals.connect("wave_beaten", self, "restock")

func _process(delta):
	if current_amount > 0:
		sprite.self_modulate = Color(1,1,1,1)
	else:
		
		sprite.self_modulate = Color(1,1,1,0.5)
	
func position_changed():
	grid_position = Grid.get_grid_position(self.position)
	Grid.set_grid_value_by_world_position(grid_position, 0)
	Grid.set_grid_value_by_world_position(self.position, 2)

func interact():
	if current_amount > 0:
		gather_sound.play()
		Resources.resources[resource_name] += 1
		current_amount -= 1

func get_info_text():
	if current_amount > 0:
		return "Hold F to collect " + resource_name
	else:
		return "Stone will restock after the next wave"

func restock(wave_number):
	current_amount = max_amount
