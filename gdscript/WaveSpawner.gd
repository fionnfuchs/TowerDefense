extends Node2D

onready var parent = get_parent()

# Wave Iterations function = 1 + (wave_number - 1) * 2

# {DEFAULT, PROB:[ENEMY_SCENE, CHANCE]}

var wave_types = [
	{"default": Scenes.simple_enemy, "probabilities": [], "repeat": 3},
	{"default": Scenes.simple_enemy, "probabilities": [[Scenes.fast_enemy, 0.4]], "repeat": 3},
	{"default": Scenes.simple_enemy, "probabilities": [[Scenes.fast_enemy, 0.3], [Scenes.tank_enemy, 0.1]], "repeat": 4},
	{"default": Scenes.simple_enemy, "probabilities": [[Scenes.simple_enemy_stronger, 0.4]], "repeat": 1},
	{"default": Scenes.simple_enemy_stronger, "probabilities": [[Scenes.fast_enemy, 0.2], [Scenes.tank_enemy, 0.1]], "repeat": 2},
	{"default": Scenes.simple_enemy_stronger, "probabilities": [[Scenes.fast_enemy, 0.2], [Scenes.tank_enemy_2, 0.1]], "repeat": 2},
]

var current_wave_type = 0
var wave_type_counter = 0

func _ready():
	Entities.wave_spawner = self

func spawn_wave():
	print("INFO: Spawning wave " + str(Difficulty.current_wave) + " with wave type " + str(current_wave_type))
	var position_index = 0
	
	for i in range(round(1 + (Difficulty.current_wave - 1) * 1.5)):
		var enemy_spawned = false
		for prob_enemy in wave_types[current_wave_type]["probabilities"]:
			print(prob_enemy)
			if chance(prob_enemy[1]):
				spawn_enemy(position_index, prob_enemy[0])
				position_index += rand_range(0.5,1)
				enemy_spawned = true
		if !enemy_spawned:
			spawn_enemy(position_index, wave_types[current_wave_type]["default"])
			position_index += rand_range(0.5,1)
	
	wave_type_counter += 1
	if current_wave_type + 1 < len(wave_types) and wave_type_counter >= wave_types[current_wave_type]["repeat"]:
		print("Increasing wave type")
		wave_type_counter = 0
		current_wave_type += 1
	
	Difficulty.current_wave += 1

func chance(chance):
	var r = rand_range(0,100)
	if r < chance * 100:
		return true
	else:
		return false

func check_state_condition():
	if len(Entities.enemies) <= 0:
		# Wave is beaten
		Signals.emit_signal("wave_beaten", 1)
		GameState.set_game_state(0)
		print("INFO: Wave beaten.")

func spawn_enemy(position_index, enemy_scene):
	var enemy_instance = enemy_scene.instance()
	parent.add_child(enemy_instance)
	enemy_instance.position = Vector2(position.x, position.y + position_index * 32)
	enemy_instance.update_navigation()
