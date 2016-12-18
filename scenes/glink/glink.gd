extends KinematicBody2D

const LEFT  = 0
const RIGHT = 1
const UP    = 2
const DOWN  = 3

export(float) var WALK_SPEED = 150

var dir = Vector2()

onready var anim = get_node("anim")
onready var sword_pivot = get_node("sword_pivot")

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
	
	if event.is_action_pressed("A"):
		anim.play("attack")

func _fixed_process(delta):
	if anim.get_current_animation() != "attack":
		move(dir * WALK_SPEED * delta)

func set_facing(new_dir):
	if new_dir == LEFT:
		sword_pivot.set_rot(deg2rad(-90))
	elif new_dir == RIGHT:
		sword_pivot.set_rot(deg2rad(90))
	elif new_dir == UP:
		sword_pivot.set_rot(deg2rad(0))
	else: # DOWN
		sword_pivot.set_rot(deg2rad(180))

func _on_sword_body_enter( body ):
	if body.is_in_group("enemy"):
		body.take_damage(1)
