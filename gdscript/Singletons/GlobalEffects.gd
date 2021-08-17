extends Node

#NEGATIVE MULTIPLIERS
var enemy_speed_multipliers = []
var enemy_health_multipliers = []
# TODO: Enemy type effects

#POSITIVE MULTIPLIERS
var resource_gathering_multipliers = []
var tower_damage_multipliers = []
var tower_speed_multipliers = []

#NEGATIVE EFFECTS
func get_total_enemy_speed_effect():
	var total_multiplier = 1
	for multiplier in enemy_speed_multipliers:
		total_multiplier *= multiplier
	return total_multiplier
	
func get_total_enemy_health_multiplier():
	var total_multiplier = 1
	for multiplier in enemy_health_multipliers:
		total_multiplier *= multiplier
	return total_multiplier

#POSITIVE EFFECTS
func get_total_resource_gathering_multiplier():
	var total_multiplier = 1
	for multiplier in resource_gathering_multipliers:
		total_multiplier *= multiplier
	return total_multiplier

func get_total_tower_damage_multiplier():
	var total_multiplier = 1
	for multiplier in tower_damage_multipliers:
		total_multiplier *= multiplier
	return total_multiplier

func get_total_tower_speed_multiplier():
	var total_multiplier = 1
	for multiplier in tower_speed_multipliers:
		total_multiplier *= multiplier
	return total_multiplier
