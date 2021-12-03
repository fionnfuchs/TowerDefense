extends StaticBody2D

func _ready():
	Entities.skill_druid = self

func interact():
	GameState.set_game_state(5)

func get_info_text():
	return "Hold F to spend crystals"

