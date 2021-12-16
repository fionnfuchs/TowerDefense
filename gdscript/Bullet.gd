extends Node2D

var movement_speed = 250
var damage = 1

var target = null
var active = false
var buffs = []

func add_buff(buff):
	buffs.append(buff)

func has_buff(buff):
	if buff in buffs:
		return true
	else:
		return false

func _ready():
	if has_buff("BOMB"):
		self.movement_speed *= 0.5

func _process(delta):
	if active:
		if target != null:
			var direction = target.position - self.position
			if direction.length() < 6:
				hit_target()
			else:
				self.position += direction.normalized() * movement_speed * delta * GameState.time_speed
		else:
			queue_free()

func update_sprite():
	if has_buff("SLOWDOWN"):
		self.get_node("Sprite").texture = Scenes.slowdown_bullet_texture
	elif has_buff("BOMB"):
		self.get_node("Sprite").texture = Scenes.bomb_bullet_texture

func hit_target():
	randomize()
	if target.has_method("get_hit"):
		target.get_hit(self.damage * GlobalEffects.get_total_tower_damage_multiplier())
		var hit_instance = Scenes.simple_hit.instance()
		hit_instance.position = self.position
		get_parent().add_child(hit_instance)
	else:
		print("WARNING: Target not hitable.")
	if has_buff("SLOWDOWN") and target.has_method("set_buff"):
		target.set_buff("SLOWDOWN")
		var hit_instance = Scenes.simple_hit.instance()
		hit_instance.position = self.position
		get_parent().add_child(hit_instance)
	if has_buff("BOMB"):
		var explosion_instance = Scenes.explosion.instance()
		explosion_instance.position = self.position
		get_parent().add_child(explosion_instance)
		Signals.emit_signal("play_global_sound", "Explosion")
	if has_buff("ICE") and target.has_method("set_buff"):
		target.set_buff("FROZEN")
	if has_buff("GOLDDROPPER"):
		var r = rand_range(0,100)
		if r < 25:
			var pickup = Scenes.gold_pickup.instance()
			pickup.position = self.position
			self.get_parent().add_child(pickup)
	if has_buff("CRYSTALDROPPER"):
		var r = rand_range(0,100)
		if r < 25:
			var pickup = Scenes.crystal_pickup.instance()
			pickup.position = self.position
			self.get_parent().add_child(pickup)
	queue_free()
