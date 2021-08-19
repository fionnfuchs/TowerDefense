extends Node2D

export(int) var movement_speed = 500
export(int) var damage = 1

var target = null
var active = false
var type = "NORMAL"

func _ready():
	
	if self.type == "BOMB":
		self.movement_speed *= 0.5

func _process(delta):
	if active:
		if target != null:
			var direction = target.position - self.position
			if direction.length() < 6:
				hit_target()
			else:
				self.position += direction.normalized() * movement_speed * delta
		else:
			queue_free()
	
	if type == "SLOWDOWN":
		self.get_node("Sprite").texture = Scenes.slowdown_bullet_texture
	elif type == "BOMB":
		self.get_node("Sprite").texture = Scenes.bomb_bullet_texture

func hit_target():
	if target.has_method("get_hit"):
		target.get_hit(self.damage * GlobalEffects.get_total_tower_damage_multiplier())
		var hit_instance = Scenes.simple_hit.instance()
		hit_instance.position = self.position
		get_parent().add_child(hit_instance)
	else:
		print("WARNING: Target not hitable.")
	if type == "SLOWDOWN" and target.has_method("set_buff"):
		target.set_buff("SLOWDOWN")
		var hit_instance = Scenes.simple_hit.instance()
		hit_instance.position = self.position
		get_parent().add_child(hit_instance)
	if type == "BOMB":
		var explosion_instance = Scenes.explosion.instance()
		explosion_instance.position = self.position
		get_parent().add_child(explosion_instance)
	queue_free()
