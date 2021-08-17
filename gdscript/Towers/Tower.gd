extends StaticBody2D

onready var attention_area = get_node("Area2D")
onready var parent = get_parent()
onready var shoot_sound = get_node("ShootSound")
onready var build_sound = get_node("BuildSound")

var enemies_in_range = []

var shoot_timer = 0


export(float) var shooting_time = 2

export(String) var bullet_type = "NORMAL"
export(String) var target_choice = "FOCUS"
export(int) var bullet_damage = 1

var grid_vector = Vector2()

func _ready():
	update_grid()
	
	attention_area.connect("body_entered", self, "body_entered_attention_area")
	attention_area.connect("body_exited", self, "body_exited_attention_area")
	
	GameState.active_towers += 1

func _process(delta):
	shoot_timer += delta
	if shoot_timer >= (shooting_time * (1 / GlobalEffects.get_total_tower_speed_multiplier())):
		if len(enemies_in_range) >= 1:
			shoot()
		shoot_timer = 0

func update_grid():
	var new_grid_vector = Grid.get_grid_position(position)
	Grid.set_grid_value(grid_vector, 0)
	Grid.set_grid_value(new_grid_vector, 1)
	
	grid_vector = new_grid_vector

func body_entered_attention_area(body):
	if body.has_node("ShootThis"):
		enemies_in_range.append(body)
	
func body_exited_attention_area(body):
	if body.has_node("ShootThis"):
		enemies_in_range.erase(body)
	
func shoot():
	shoot_sound.play()
	var bullet_instance = Scenes.basic_bullet.instance()
	parent.add_child(bullet_instance)
	bullet_instance.position = self.position
	if target_choice == "FOCUS":
		bullet_instance.target = enemies_in_range[0]
	elif target_choice == "RANDOM":
		bullet_instance.target = enemies_in_range[int(rand_range(0,len(enemies_in_range)-1))]
	bullet_instance.active = true
	bullet_instance.damage = self.bullet_damage
	bullet_instance.type = bullet_type

func interact():
	GameState.active_towers -= 1
	queue_free()

func play_build_sound():
	build_sound.play()
	
func upgrade_tower():
	pass

func get_info_text():
	return "Hold F to destroy this tower"
