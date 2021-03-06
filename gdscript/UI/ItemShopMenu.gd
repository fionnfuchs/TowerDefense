extends Panel

onready var cancel_button = $CancelButton

onready var item_1_name_label = $Item1/NameLabel
onready var item_1_icon_texture_rect = $Item1/ItemIcon
onready var item_1_description_label = $Item1/Description
onready var item_1_cost_label = $Item1/CostLabel
onready var item_1_buy_button = $Item1/BuyButton

onready var item_2_name_label = $Item2/NameLabel
onready var item_2_icon_texture_rect = $Item2/ItemIcon
onready var item_2_description_label = $Item2/Description
onready var item_2_cost_label = $Item2/CostLabel
onready var item_2_buy_button = $Item2/BuyButton

onready var item_3_name_label = $Item3/NameLabel
onready var item_3_icon_texture_rect = $Item3/ItemIcon
onready var item_3_description_label = $Item3/Description
onready var item_3_cost_label = $Item3/CostLabel
onready var item_3_buy_button = $Item3/BuyButton

onready var reroll_button = $RerollButton

var item_1_id = 1
var item_2_id = 2
var item_3_id = 0

var reroll_cost = 5

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	cancel_button.connect("button_up", self, "cancel")
	
	item_1_buy_button.connect("button_up", self, "buy_item_1")
	item_2_buy_button.connect("button_up", self, "buy_item_2")
	item_3_buy_button.connect("button_up", self, "buy_item_3")
	
	reroll_button.connect("button_up", self, "reroll_button_pressed")
	
	Signals.connect("wave_beaten", self, "on_wave_beaten")
	Signals.connect("gold_updated", self, "update_exclamation_symbol")

func _process(delta):
	if GameState.game_state == 3:
		self.visible = true
	else:
		self.visible = false
	
	if Resources.resources["gold"] >= reroll_cost:
		reroll_button.disabled = false
	else:
		reroll_button.disabled = true
	
	reroll_button.text = "Reroll for " + str(reroll_cost) + " gold"
	
	if item_1_id == 0:
		item_1_name_label.text = "No item available"
		item_1_description_label.text = ""
		item_1_cost_label.text = ""
		item_1_icon_texture_rect.texture = null
		item_1_buy_button.disabled = true
	else:
		item_1_name_label.text = Items.get_item_name(item_1_id)
		item_1_description_label.text = Items.get_item_description(item_1_id)
		item_1_cost_label.text = "Cost: " + str(Items.get_item_base_price(item_1_id) + 10 * GameState.items_bought)
		item_1_icon_texture_rect.texture = Items.get_item_icon(item_1_id)
		item_1_buy_button.disabled = false
	
	if item_2_id == 0:
		item_2_name_label.text = "No item available"
		item_2_description_label.text = ""
		item_2_cost_label.text = ""
		item_2_icon_texture_rect.texture = null
		item_2_buy_button.disabled = true
	else:
		item_2_name_label.text = Items.get_item_name(item_2_id)
		item_2_description_label.text = Items.get_item_description(item_2_id)
		item_2_cost_label.text = "Cost: " + str(Items.get_item_base_price(item_2_id) + 10 * GameState.items_bought)
		item_2_icon_texture_rect.texture = Items.get_item_icon(item_2_id)
		item_2_buy_button.disabled = false
	
	if item_3_id == 0:
		item_3_name_label.text = "No item available"
		item_3_description_label.text = ""
		item_3_cost_label.text = ""
		item_3_icon_texture_rect.texture = null
		item_3_buy_button.disabled = true
	else:
		item_3_name_label.text = Items.get_item_name(item_3_id)
		item_3_description_label.text = Items.get_item_description(item_3_id)
		item_3_cost_label.text = "Cost: " + str(Items.get_item_base_price(item_3_id) + 10 * GameState.items_bought)
		item_3_icon_texture_rect.texture = Items.get_item_icon(item_3_id)
		item_3_buy_button.disabled = false

func cancel():
	GameState.set_game_state(0)

func buy_item_1():
	if Resources.resources["gold"] >= Items.get_item_base_price(item_1_id) + 10 * GameState.items_bought:
		Resources.resources["gold"] -= Items.get_item_base_price(item_1_id) + 10 * GameState.items_bought
		Entities.player.set_carried_item(item_1_id)
		print("Bought item: " + str(item_1_id))
		GameState.items_bought += 1
		item_1_id = 0
		update_exclamation_symbol()

func buy_item_2():
	if Resources.resources["gold"] >= Items.get_item_base_price(item_2_id) + 10 * GameState.items_bought:
		Resources.resources["gold"] -= Items.get_item_base_price(item_2_id) + 10 * GameState.items_bought
		Entities.player.set_carried_item(item_2_id)
		GameState.items_bought += 1
		print("Bought item: " + str(item_2_id))
		item_2_id = 0
		update_exclamation_symbol()

func buy_item_3():
	if Resources.resources["gold"] >= Items.get_item_base_price(item_3_id) + 10 * GameState.items_bought:
		Resources.resources["gold"] -= Items.get_item_base_price(item_3_id) + 10 * GameState.items_bought
		Entities.player.set_carried_item(item_3_id)
		GameState.items_bought += 1
		print("Bought item: " + str(item_3_id))
		item_3_id = 0
		update_exclamation_symbol()

func on_wave_beaten(wave_number):
	reroll_cost = 5
	if wave_number > 5:
		if wave_number % 6 == 0:
			reroll_item_1()
			reroll_item_2()
			Entities.notification_panel.queue_notification("New items available at the item shop!")

func update_exclamation_symbol():
	if can_buy_item():
		Entities.item_shop.exclamation_symbol.visible = true
	else:
		Entities.item_shop.exclamation_symbol.visible = false

func reroll_button_pressed():
	if Resources.resources["gold"] >= reroll_cost:
		reroll_item_1()
		reroll_item_2()
		Resources.resources["gold"] -= reroll_cost
		reroll_cost += 5
		update_exclamation_symbol()

func reroll_item_1():
	item_1_id = rng.randi_range(1,9)
	update_exclamation_symbol()

func reroll_item_2():
	item_2_id = rng.randi_range(1,9)
	update_exclamation_symbol()

func can_buy_item():
	if item_1_id > 0 and Resources.resources["gold"] >= Items.get_item_base_price(item_1_id) + 10 * GameState.items_bought:
		return true
	if item_1_id > 0 and Resources.resources["gold"] >= Items.get_item_base_price(item_2_id) + 10 * GameState.items_bought:
		return true
	if item_1_id > 0 and Resources.resources["gold"] >= Items.get_item_base_price(item_3_id) + 10 * GameState.items_bought:
		return true
	return false
