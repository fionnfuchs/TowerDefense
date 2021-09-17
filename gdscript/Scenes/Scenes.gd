extends Node

#SCENES:
var simple_tower = preload("res://scenes/Towers/SimpleTower.tscn")

var simple_enemy = preload("res://scenes/Enemies/BasicEnemy.tscn")
var simple_enemy_stronger = preload("res://scenes/Enemies/BasicEnemyStronger.tscn")
var fast_enemy = preload("res://scenes/Enemies/FastEnemy.tscn")
var tank_enemy = preload("res://scenes/Enemies/TankEnemy.tscn")
var tank_enemy_2 = preload("res://scenes/Enemies/TankEnemy2.tscn")

var basic_bullet = preload("res://scenes/Towers/Bullet.tscn")

var gold_pickup = preload("res://scenes/Resources/Gold.tscn")

var explosion = preload("res://scenes/Effects/Explosion.tscn")
var simple_hit = preload("res://scenes/Effects/SimpleHit.tscn")

var gold_chest = preload("res://scenes/MapObjects/GoldChest.tscn")


#TEXTURES:
var simple_bullet_texture = preload("res://sprites/prototype/prototype_bullet.png")
var slowdown_bullet_texture = preload("res://sprites/prototype/bullets/slowdown_bullet.png")
var bomb_bullet_texture = preload("res://sprites/prototype/bullets/bomb.png")
var chest_texture = preload("res://sprites/prototype/map_objects/chest.png")
