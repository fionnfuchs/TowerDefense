extends KinematicBody2D


export(int) var movement_speed = 1000

export(int) var max_hp = 3

onready var hp = max_hp

onready var healthbar = get_node("HealthBar")
onready var navigation_2d = get_node("../../PathNavigation2D")
onready var line2d = get_node("Line2D")

var current_buff = "NONE"
var target = Vector2(8,-32)

var path = null

func _ready():
	Entities.enemies.append(self)
	
func update_navigation():
	if navigation_2d != null:
		self.path = navigation_2d.get_simple_path(position, target, false)
		print(navigation_2d.get_closest_point_owner(position))
	

func die():
	var rand = rand_range(0,2)
	if rand > 1:
		var gold_pickup = Scenes.gold_pickup.instance()
		self.get_parent().add_child(gold_pickup)
		gold_pickup.position = self.position
	Entities.enemies.erase(self)
	Entities.wave_spawner.check_state_condition()
	queue_free()

func _process(delta):
	if GameState.game_state == 1:
		process_movement(delta)
	healthbar.scale.x = float(hp) / max_hp
	healthbar.position.x = (1 - float(hp) / max_hp) * -8

func process_movement(delta):
	line2d.global_position = Vector2.ZERO
	if path and len(path) > 0:
		line2d.points = path
		var distance_to_next = position.distance_to(path[0])
		if distance_to_next < 1:
			path.remove(0)
		
	if path and len(path) > 0:
		var direction = path[0] - position
		direction = direction.normalized()
		if current_buff != "SLOWDOWN":
			move_and_slide(direction * movement_speed * delta)
		else:
			move_and_slide(direction * movement_speed * delta / 2)
	
	if !path or len(path) == 0:
		print("Enemy left path")
		var direction = target - position
		if current_buff != "SLOWDOWN":
			move_and_slide(direction * movement_speed * delta)
		else:
			move_and_slide(direction * movement_speed * delta / 2)

func get_hit(damage):
	self.hp -= damage
	if hp <= 0:
		self.die()

func set_buff(new_buff):
	current_buff = new_buff
