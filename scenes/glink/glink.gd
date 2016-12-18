extends KinematicBody2D

const LEFT  = 0
const RIGHT = 1
const UP    = 2
const DOWN  = 3

export(float) var WALK_SPEED = 150

var dir = Vector2()
var item_a
var item_b

onready var anim = get_node("anim")
onready var item_container = get_node("item_container")

func _init():
	add_to_group("player")
	Globals.set("player", self)

func _ready():
	set_process_input(true)
	set_fixed_process(true)

func _input(event):
	dir = Vector2()
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	
	if anim.get_current_animation() == "attack":
		dir.normalized()
		return
	
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0: set_facing(LEFT)
		else: set_facing(RIGHT)
	elif abs(dir.x) < abs(dir.y):
		if dir.y > 0: set_facing(DOWN)
		else: set_facing(UP)
	dir.normalized()
	
	if item_a != null && event.is_action_pressed("A"):
		item_a.use()
	if item_a != null && event.is_action_released("A"):
		item_a.release()
	if item_b != null && event.is_action_pressed("B"):
		item_b.use()
	if item_b != null && event.is_action_released("B"):
		item_b.release()
		

func _fixed_process(delta):
	if anim.get_current_animation() != "attack":
		move(dir * WALK_SPEED * delta)

func set_facing(new_dir):
	if new_dir == LEFT:
		item_container.set_rot(deg2rad(-90))
	elif new_dir == RIGHT:
		item_container.set_rot(deg2rad(90))
	elif new_dir == UP:
		item_container.set_rot(deg2rad(0))
	else: # DOWN
		item_container.set_rot(deg2rad(180))

func take_damage(amount):
	get_node("Sprite").set_modulate(Color(1,0,0,1))
	var t = Timer.new()
	add_child(t)
	t.start()
	yield(t,"timeout")
	get_node("Sprite").set_modulate(Color(1,1,1,1))
	t.queue_free()