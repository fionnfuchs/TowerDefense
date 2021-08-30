extends StaticBody2D

onready var attention_area = get_node("Area2D")
onready var parent = get_parent()
onready var shoot_sound = get_node("ShootSound")
onready var build_sound = get_node("BuildSound")
onready var item_sprite = get_node("ItemSprite")
onready var radius_sprite = get_node("Radius")

var enemies_in_range = []

var shoot_timer = 0

var equipped_item = 0

export(float) var shooting_time = 2
export(float) var attention_radius = 45

export(String) var bullet_buffs = []
export(String) var target_choice = "FOCUS"
export(int) var bullet_damage = 1


var grid_vector = Vector2()

func _ready():
	update_grid()
	update_attention_radius()
	
	attention_area.connect("body_entered", self, "body_entered_attention_area")
	attention_area.connect("body_exited", self, "body_exited_attention_area")
	
	GameState.active_towers += 1

func _process(delta):
	shoot_timer += delta
	if shoot_timer >= (shooting_time * (1 / GlobalEffects.get_total_tower_speed_multiplier())):
		if len(enemies_in_range) >= 1:
			shoot()
		shoot_timer = 0
	
	if equipped_item > 0:
		item_sprite.visible = true
	else:
		item_sprite.visible = false
	
func equip_item(item_id):
	self.equipped_item = item_id
	item_sprite.texture = Items.get_item_icon(item_id)
	update_tower_stats_by_item()

func update_grid():
	var new_grid_vector = Grid.get_grid_position(position)
	Grid.set_grid_value(grid_vector, 0)
	Grid.set_grid_value(new_grid_vector, 1)
	
	grid_vector = new_grid_vector

func body_entered_attention_area(body):
	if body.has_node("ShootThis"):
		enemies_in_range.append(body)
	
func body_exited_attention_area(body):
	if body.has_node("ShootThis"):
		enemies_in_range.erase(body)
	
func shoot():
	shoot_sound.play()
	var bullet_instance = Scenes.basic_bullet.instance()
	parent.add_child(bullet_instance)
	bullet_instance.position = self.position
	if target_choice == "FOCUS":
		bullet_instance.target = enemies_in_range[0]
	elif target_choice == "RANDOM":
		bullet_instance.target = enemies_in_range[int(rand_range(0,len(enemies_in_range)-1))]
	elif target_choice == "BUFF_BASED":
		bullet_instance.target = enemies_in_range[0]
		for enemy in enemies_in_range:
			if !enemy.has_buff(bullet_buffs[0]):
				bullet_instance.target = enemy
				break
	bullet_instance.active = true
	bullet_instance.damage = self.bullet_damage
	bullet_instance.buffs = bullet_buffs

func interact():
	if Entities.player.carried_item != 0:
		self.equip_item(Entities.player.carried_item)
		Entities.player.set_carried_item(0)

func play_build_sound():
	build_sound.play()
	

func get_info_text():
	if Entities.player.carried_item != 0:
		return "Hold F to upgrade this tower with your item"
	else:
		return "You can buy items in the shop to upgrade towers"
	
func update_tower_stats_by_item():
	if equipped_item == 1: #SLOWDOWN
		bullet_buffs = ["SLOWDOWN"]
		target_choice = "BUFF_BASED"
		bullet_damage = 0.5
		shooting_time = 1.0
	if equipped_item == 2: #DOUBLE DAMAGE
		bullet_damage = 2
	if equipped_item == 3: #BOMBS
		bullet_damage = 1
		bullet_buffs = ["BOMB"]
		target_choice = "RANDOM"
	if equipped_item == 4:
		bullet_damage = 0.5
		shooting_time = 0.15
	if equipped_item == 5:
		attention_radius = 75
		update_attention_radius()

func update_attention_radius():
	attention_area.get_node("CollisionShape2D").get_shape().set_radius(attention_radius)
	radius_sprite.scale.x = 1.4 * (attention_radius / 45.0)
	radius_sprite.scale.y = 1.4 * (attention_radius / 45.0)
