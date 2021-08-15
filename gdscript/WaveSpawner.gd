extends Node2D

onready var parent = get_parent()

func _ready():
	Entities.wave_spawner = self

func spawn_wave():
	print("INFO: Spawning wave " + str(Difficulty.current_wave))
	for i in range(Difficulty.current_wave * floor(Difficulty.difficulty)):#
		#TODO: Clean this up
		if Difficulty.current_wave < 2:
			var enemy_instance = Scenes.simple_enemy.instance()
			parent.add_child(enemy_instance)
			enemy_instance.position = Vector2(position.x, position.y + i * 32)
			enemy_instance.update_navigation()
		elif Difficulty.current_wave < 5:
			var r = rand_range(1,10)
			if r < 8:
				var enemy_instance = Scenes.simple_enemy.instance()
				parent.add_child(enemy_instance)
				enemy_instance.position = Vector2(position.x, position.y + i * 32)
				enemy_instance.update_navigation()
			else:
				var enemy_instance = Scenes.fast_enemy.instance()
				parent.add_child(enemy_instance)
				enemy_instance.position = Vector2(position.x, position.y + i * 32)
				enemy_instance.update_navigation()
		else:
			var r = rand_range(1,10)
			if r < 6:
				var enemy_instance = Scenes.simple_enemy.instance()
				parent.add_child(enemy_instance)
				enemy_instance.position = Vector2(position.x, position.y + i * 32)
				enemy_instance.update_navigation()
			elif r < 9:
				var enemy_instance = Scenes.fast_enemy.instance()
				parent.add_child(enemy_instance)
				enemy_instance.position = Vector2(position.x, position.y + i * 32)
				enemy_instance.update_navigation()
			else:
				var enemy_instance = Scenes.tank_enemy.instance()
				parent.add_child(enemy_instance)
				enemy_instance.position = Vector2(position.x, position.y + i * 32)
				enemy_instance.update_navigation()
	Difficulty.current_wave += 1

func check_state_condition():
	if len(Entities.enemies) <= 0:
		# Wave is beaten
		Signals.emit_signal("wave_beaten", 1)
		GameState.set_game_state(0)
		print("INFO: Wave beaten.")
