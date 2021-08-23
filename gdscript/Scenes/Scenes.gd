extends Node

#SCENES:
var simple_tower = preload("res://scenes/Towers/SimpleTower.tscn")

var simple_enemy = preload("res://scenes/Enemies/BasicEnemy.tscn")
var fast_enemy = preload("res://scenes/Enemies/FastEnemy.tscn")
var tank_enemy = preload("res://scenes/Enemies/TankEnemy.tscn")

var basic_bullet = preload("res://scenes/Towers/Bullet.tscn")

var gold_pickup = preload("res://scenes/Resources/Gold.tscn")

var explosion = preload("res://scenes/Effects/Explosion.tscn")
var simple_hit = preload("res://scenes/Effects/SimpleHit.tscn")


#TEXTURES:
var simple_bullet_texture = preload("res://sprites/prototype/prototype_bullet.png")
var slowdown_bullet_texture = preload("res://sprites/prototype/bullets/slowdown_bullet.png")
var bomb_bullet_texture = preload("res://sprites/prototype/bullets/bomb.png")
