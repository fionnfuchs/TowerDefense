extends KinematicBody2D


export(int) var movement_speed = 1000

export(int) var max_hp = 3

onready var hp = max_hp

onready var healthbar = get_node("HealthBar")

var movement_target = Vector2(8,-8)

func _ready():
	Entities.enemies.append(self)

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
	var direction = (movement_target - self.position).normalized()
	move_and_slide(direction * movement_speed * delta)

func get_hit(damage):
	self.hp -= damage
	if hp <= 0:
		self.die()