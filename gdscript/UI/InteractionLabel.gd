extends Label

onready var f_button_texture = $FButtonTexture


func _ready():
	Signals.connect("interaction_target_changed", self, "interaction_target_changed")

func interaction_target_changed(new_target):
	if GameState.game_state == 0 and new_target.has_method("get_info_text"):
		self.text = new_target.get_info_text()
	else:
		print("WARNING: No info text implemented for interaction target")
		self.text = ""

func _process(delta):
	if Entities.player.interaction_target == null:
		self.text = ""
	if GameState.interaction_mode != 0 or GameState.game_state != 0:
		self.visible = false
	else:
		self.visible = true
	
	if self.text != "":
		f_button_texture.visible = true
	else:
		f_button_texture.visible = false
