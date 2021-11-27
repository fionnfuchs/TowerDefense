extends KinematicBody2D


export(int) var movement_speed = 1000

export(int) var max_hp = 3

onready var hp = max_hp

onready var healthbar = get_node("HealthBar")
onready var navigation_2d = get_node("../../PathNavigation2D")
onready var line2d = get_node("Line2D")
onready var hitsound = get_node("HitSound")

var buffs = []
var target = Vector2(8,-32)

var path = null

func _ready():
	Entities.enemies.append(self)
	self.max_hp = max_hp * GlobalEffects.get_total_enemy_health_multiplier() + (max_hp/55) * floor(Difficulty.difficulty)
	self.hp = self.max_hp
	
func update_navigation():
	if navigation_2d != null:
		self.path = navigation_2d.get_simple_path(position, target, false)
	

func die():
	var rand = rand_range(0,2)
	if rand > 1:
		var gold_pickup = Scenes.gold_pickup.instance()
		self.get_parent().add_child(gold_pickup)
		gold_pickup.position = self.position
	Entities.enemies.erase(self)
	Entities.wave_spawner.check_state_condition()
	queue_free()

func _physics_process(delta):
	if GameState.game_state == 1:
		process_movement()

func _process(delta):
	healthbar.scale.x = float(hp) / max_hp
	healthbar.position.x = (1 - float(hp) / max_hp) * -8

func process_movement():
	line2d.global_position = Vector2.ZERO
	if path and len(path) > 0:
		line2d.points = path
		var distance_to_next = position.distance_to(path[0])
		if distance_to_next < 1:
			path.remove(0)
		
	if path and len(path) > 0:
		var direction = path[0] - position
		direction = direction.normalized()
		if not "SLOWDOWN" in buffs:
			move_and_slide(direction * movement_speed * GlobalEffects.get_total_enemy_speed_effect() * GameState.time_speed / 50)
		else:
			move_and_slide(direction * movement_speed * GlobalEffects.get_total_enemy_speed_effect() / 1.6 * GameState.time_speed / 50)
	
	if !path or len(path) == 0:
		var direction = target - position
		if not "SLOWDOWN" in buffs:
			move_and_slide(direction * movement_speed * GlobalEffects.get_total_enemy_speed_effect() * GameState.time_speed / 50)
		else:
			move_and_slide(direction * movement_speed * GlobalEffects.get_total_enemy_speed_effect() / 1.6 * GameState.time_speed / 50)

func get_hit(damage):
	hitsound.play()
	self.hp -= damage
	if hp <= 0:
		self.die()

func set_buff(new_buff):
	if not new_buff in buffs:
		buffs.append(new_buff)

func remove_buff(buff):
	if buff in buffs:
		buffs.erase(buff)

func has_buff(buff):
	if buff in buffs:
		return true
	return false
