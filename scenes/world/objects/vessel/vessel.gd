extends KinematicBody2D

const PUSH_STRENGHT = 1
const PICK_STRENGHT = 2
const NEEDED_PUSH   = 1

export (float) var push_acum = 0
var moving = false
var last_dir = Vector2()

onready var ray = get_node("ray")
onready var shadow = get_node("shadow")
onready var pick_anim = get_node("pick_anim")
onready var tween = Tween.new()

func _init():
	add_to_group("pushable")
	add_to_group("can_pickup")

func _ready():
	add_child(tween)
	tween.set_tween_process_mode(tween.TWEEN_PROCESS_FIXED)
	ray.add_exception(self)

func push(delta,strength,dir):
	if moving:
		return
	if dir != last_dir:
		push_acum = 0
		ray.set_cast_to(dir*20)
	last_dir = dir
	if strength >= PUSH_STRENGHT:
		push_acum += delta * 4
		set_fixed_process(true)

func _fixed_process(delta):
	push_acum -= delta
	push_acum = clamp(push_acum,0,NEEDED_PUSH)
	if push_acum == 0:
		set_fixed_process(false)
	elif push_acum == NEEDED_PUSH:
		if ray.is_colliding():
			push_acum = 0
			return
		else:
			moving = true
			set_fixed_process(false)
			translate(last_dir)

func translate(dir):
	dir = dir * 32
	tween.stop_all()
	tween.interpolate_property(self,"transform/pos",get_pos(),get_pos()+dir,0.5,tween.TRANS_LINEAR,tween.EASE_IN_OUT)
	tween.start()
	yield(tween,"tween_complete")
	push_acum = 0
	moving = false

func _on_shadow_draw():
	shadow.draw_circle(Vector2(),32,Color(0,0,0,0.5))
