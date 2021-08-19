extends Panel

onready var spell1_positive_effect_label = $Spell1/PositiveEffect
onready var spell1_negative_effect_label = $Spell1/NegativeEffect
onready var spell1_cast_button = $Spell1/CastButton

onready var spell2_positive_effect_label = $Spell2/PositiveEffect
onready var spell2_negative_effect_label = $Spell2/NegativeEffect
onready var spell2_cast_button = $Spell2/CastButton

onready var cancel_button = $CancelButton

func _ready():
	spell1_cast_button.connect("button_up", self, "cast_spell1")
	spell2_cast_button.connect("button_up", self, "cast_spell2")
	cancel_button.connect("button_up", self, "cancel")
	pass

func _process(delta):
	if GameState.game_state == 2:
		self.visible = true
	else:
		self.visible = false
	
	if Resources.resources.gold < 25:
		spell1_cast_button.disabled = true
		spell2_cast_button.disabled = true
		spell1_cast_button.text = "Not enough gold"
		spell2_cast_button.text = "Not enough gold"
	else:
		spell1_cast_button.disabled = false
		spell2_cast_button.disabled = false
		spell1_cast_button.text = "Cast this spell"
		spell2_cast_button.text = "Cast this spell"
		

func cast_spell1():
	if Resources.resources.gold >= 25:
		Resources.resources.gold -= 25
		
		GlobalEffects.tower_speed_multipliers.append(1.2)
		GlobalEffects.enemy_health_multipliers.append(1.15)
		
		print("Spell 1 casted")
		GameState.set_game_state(0)
	pass
	
func cast_spell2():
	if Resources.resources.gold >= 25:
		Resources.resources.gold -= 25
		
		GlobalEffects.tower_damage_multipliers.append(1.25)
		GlobalEffects.enemy_speed_multipliers.append(1.2)
		
		print("Spell 2 casted")
		GameState.set_game_state(0)
	pass
	
func cancel():
	GameState.set_game_state(0)
	pass
