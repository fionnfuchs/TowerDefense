extends StaticBody2D

func interact():
	GameState.set_game_state(3)

func get_info_text():
	return "Hold F to talk to the shopkeeper"
