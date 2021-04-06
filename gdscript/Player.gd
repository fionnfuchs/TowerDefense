extends KinematicBody2D

var movement_speed = 150

func _ready():
	pass

func _process(delta):

	var move_direction = Vector2(0,0)

	if Input.is_action_pressed("ui_up"):
		move_direction.y = -1
	if Input.is_action_pressed("ui_down"):
		move_direction.y = 1
	if Input.is_action_pressed("ui_left"):
		move_direction.x = -1
	if Input.is_action_pressed("ui_right"):
		move_direction.x = 1
	
	if Input.is_action_just_pressed("ui_accept"):
		print(Grid.get_grid_value_by_world_position(self.position))
	
	self.move_and_slide(move_direction.normalized() * movement_speed * delta * 100)
	
	
