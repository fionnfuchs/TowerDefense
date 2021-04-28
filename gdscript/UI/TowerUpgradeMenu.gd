extends Control

var player = null

func _ready():
	player = Entities.player
	
func _process(delta):
	if GameState.interaction_mode == 0 and player.interaction_target and player.interaction_target.has_method("upgrade_tower"):
		self.visible = true
	else:
		self.visible = false
