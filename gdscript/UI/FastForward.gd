extends TextureRect

onready var toggle_button = get_node("Button")

func _ready():
	toggle_button.connect("button_up", self, "toggle_time_speed")
	Signals.connect("wave_beaten", self, "reset_time_speed")
	
func _process(delta):
	if GameState.game_state == 1:
		self.visible = true
	else:
		self.visible = false
	
	if GameState.time_speed == 1:
		self.self_modulate = Color(1,1,1,0.5)
	else:
		self.self_modulate = Color(1,1,1,1)

func toggle_time_speed():
	if GameState.time_speed == 1:
		GameState.time_speed = 2
	else:
		GameState.time_speed = 1
	print(GameState.time_speed)

func reset_time_speed():
	GameState.time_speed = 1
