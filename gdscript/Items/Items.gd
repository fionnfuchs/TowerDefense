extends Node

var item_icons = [preload("res://sprites/prototype/Items/prototype_item_1.png"), preload("res://sprites/prototype/Items/prototype_item_2.png"), preload("res://sprites/prototype/Items/prototype_item_3.png")]
var item_names = ["Slowdown Gel", "Double Damage", "Bombs"]
var item_descriptions = ["Tower shoots gel bullets that slow enemies down", "Tower deals double damage", "Tower throws bombs that inflict area damage"]
var item_base_prices = [10,30,30]

func get_item_icon(item_id):
	return item_icons[item_id-1]

func get_item_name(item_id):
	return item_names[item_id-1]

func get_item_description(item_id):
	return item_descriptions[item_id-1]
	
func get_item_base_price(item_id):
	return item_base_prices[item_id-1]
