extends StaticBody2D

onready var enemy_hit_area = get_node("EnemyHitArea")
onready var health_bar = get_node("HealthBarBackground/HealthBar")

var hp = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_hit_area.connect("body_entered", self, "enemy_entered")

func _process(delta):
	if hp != 3:
		health_bar.get_parent().visible = true
		health_bar.scale.x = float(hp) / 3
		health_bar.position.x = (1 - float(hp) / 3) * -8
	if hp <= 0:
		GameState.game_state = 9999
	
func interact():
	GameState.set_game_state(1)
	Signals.emit_signal("play_global_sound", "WaveStart")
	Entities.wave_spawner.spawn_wave()
	Entities.player.interaction_target = null

func get_info_text():
	return "Hold F to end day"

func enemy_entered(body):
	if "Enemy" in body.name:
		body.queue_free()
		body.die()
		self.hp -= 1
		if self.hp <= 0:
			print("You Lose...")
