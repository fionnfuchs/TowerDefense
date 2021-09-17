extends Panel

onready var text_label = get_node("Label")
onready var icon_texture_rect = get_node("TextureRect")
onready var timer = get_node("Timer")

var default_icon = preload("res://sprites/prototype/exclamation_symbol.png")

var notification_queue = []

var in_animation = false
var moving_back = false
var target_y = -40

func _ready():
	timer.connect("timeout", self, "move_back")
	Entities.notification_panel = self
	
func _process(delta):
	if !in_animation and notification_queue.size() > 0:
		print(notification_queue[0])
		text_label.text = notification_queue[0]["text"]
		icon_texture_rect.texture = notification_queue[0]["icon"]
		notification_queue.pop_front()
		
		trigger_animation()
	
	if rect_position.y > target_y:
		rect_position.y -= 2
	elif rect_position.y < target_y:
		rect_position.y += 2
		
	if rect_position.y == -40 and moving_back:
		moving_back = false
		in_animation = false
		target_y = -40
		

func trigger_animation():
	in_animation = true
	target_y = 0
	timer.start()

func move_back():
	target_y = -40
	moving_back = true
	
func animation_completed():
	in_animation = false
	

func queue_notification(text, icon=null):
	var notification_icon = default_icon
	
	if icon != null:
		notification_icon = icon
	
	notification_queue.append({"icon":notification_icon, "text":text})
		
