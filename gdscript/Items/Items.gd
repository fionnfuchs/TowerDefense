extends Node

var item_icons = [preload("res://sprites/prototype/Items/prototype_item_1.png"), preload("res://sprites/prototype/Items/prototype_item_2.png"), preload("res://sprites/prototype/Items/prototype_item_3.png"), preload("res://sprites/prototype/Items/prototype_item_4.png"), preload("res://sprites/prototype/Items/prototype_item_5.png"), preload("res://sprites/prototype/Items/prototype_item_6.png"), preload("res://sprites/prototype/Items/prototype_item_7.png"), preload("res://sprites/prototype/Items/prototype_item_8.png"), preload("res://sprites/prototype/Items/prototype_item_9.png")]
var item_names = ["Slowdown Gel", "Double Damage", "Bombs", "Machine Gun", "Binoculars", "Triple Damage", "Ice Crystal", "Gold Dropper", "Crystal Dropper"]
var item_descriptions = ["Tower shoots gel bullets that slow enemies down", "Tower deals double damage", "Tower throws bombs that inflict area damage", "Tower shoots bullets at incredible speed", "Increases the range that the tower can shoot", "Tower deals triple damage", "Tower freezes enemies", "Bullets sometimes drop gold on hit", "Bullets sometimes drop crystals on hit"]
var item_base_prices = [10,25,25,30,25,50,40,60,60]

func get_item_icon(item_id):
	return item_icons[item_id-1]

func get_item_name(item_id):
	return item_names[item_id-1]

func get_item_description(item_id):
	return item_descriptions[item_id-1]
	
func get_item_base_price(item_id):
	return item_base_prices[item_id-1]
