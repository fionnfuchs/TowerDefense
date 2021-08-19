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

var item_1_id = 1
var item_2_id = 2
var item_3_id = 0

func _ready():
	cancel_button.connect("button_up", self, "cancel")
	
	item_1_buy_button.connect("button_up", self, "buy_item_1")
	item_2_buy_button.connect("button_up", self, "buy_item_2")
	item_3_buy_button.connect("button_up", self, "buy_item_3")

func _process(delta):
	if GameState.game_state == 3:
		self.visible = true
	else:
		self.visible = false
	
	
	if item_1_id == 0:
		item_1_name_label.text = "No item available"
		item_1_description_label.text = ""
		item_1_cost_label.text = ""
		item_1_icon_texture_rect.texture = null
		item_1_buy_button.disabled = true
	else:
		item_1_name_label.text = Items.get_item_name(item_1_id)
		item_1_description_label.text = Items.get_item_description(item_1_id)
		item_1_cost_label.text = "Cost: " + str(Items.get_item_base_price(item_1_id))
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
		item_2_cost_label.text = "Cost: " + str(Items.get_item_base_price(item_2_id))
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
		item_3_cost_label.text = "Cost: " + str(Items.get_item_base_price(item_3_id))
		item_3_icon_texture_rect.texture = Items.get_item_icon(item_3_id)
		item_3_buy_button.disabled = false

func cancel():
	GameState.set_game_state(0)

func buy_item_1():
	if Resources.resources["gold"] >= Items.get_item_base_price(item_1_id):
		Resources.resources["gold"] -= Items.get_item_base_price(item_1_id)
		Entities.player.set_carried_item(item_1_id)
		item_1_id = 0

func buy_item_2():
	if Resources.resources["gold"] >= Items.get_item_base_price(item_2_id):
		Resources.resources["gold"] -= Items.get_item_base_price(item_2_id)
		Entities.player.set_carried_item(item_2_id)
		item_2_id = 0

func buy_item_3():
	if Resources.resources["gold"] >= Items.get_item_base_price(item_3_id):
		Resources.resources["gold"] -= Items.get_item_base_price(item_3_id)
		Entities.player.set_carried_item(item_3_id)
		item_3_id = 0
