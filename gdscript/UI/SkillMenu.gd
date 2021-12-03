extends Panel

onready var skill_cost_label = get_node("CrystalLabel")
onready var damage_multiplier_label = get_node("DamageButton/Multiplier")
onready var speed_multiplier_label = get_node("SpeedButton/Multiplier")
onready var gold_multiplier_label = get_node("GoldButton/Multiplier")

func _ready():
	get_node("CancelButton").connect("button_up", self, "cancel")
	get_node("DamageButton").connect("button_up", self, "damage_button_pressed")
	get_node("SpeedButton").connect("button_up", self, "speed_button_pressed")
	get_node("GoldButton").connect("button_up", self, "gold_button_pressed")

func _process(delta):
	if GameState.game_state == 5:
		self.visible = true
	else:
		self.visible = false
	
	skill_cost_label.text = str(get_skill_price())
	damage_multiplier_label.text = str(round(GlobalEffects.get_total_tower_damage_multiplier()*100)/100) + "x"
	speed_multiplier_label.text = str(round(GlobalEffects.get_total_tower_speed_multiplier()*100)/100) + "x"
	gold_multiplier_label.text = str(round(GlobalEffects.get_total_gold_drop_multiplier()*100)/100) + "x"

func get_skill_price():
	return len(GlobalEffects.tower_damage_multipliers) + len(GlobalEffects.tower_speed_multipliers) + len(GlobalEffects.gold_drop_multipliers)

func cancel():
	GameState.set_game_state(0)

func damage_button_pressed():
	if Resources.resources["crystal"] > get_skill_price():
		Resources.resources["crystal"] -= get_skill_price()
		GlobalEffects.tower_damage_multipliers.append(1.05)
		

func speed_button_pressed():
	if Resources.resources["crystal"] > get_skill_price():
		Resources.resources["crystal"] -= get_skill_price()
		GlobalEffects.tower_speed_multipliers.append(1.05)

func gold_button_pressed():
	if Resources.resources["crystal"] > get_skill_price():
		Resources.resources["crystal"] -= get_skill_price()
		GlobalEffects.gold_drop_multipliers.append(1.05)
