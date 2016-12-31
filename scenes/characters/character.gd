extends KinematicBody2D

const LEFT  = 0
const RIGHT = 1
const UP    = 2
const DOWN  = 3

export(float) var WALK_SPEED = 150

var dir = Vector2()
var is_player = false
var facing = DOWN setget set_facing,get_facing
var can_take_damage = true

onready var anim = get_node("anim")
onready var item_container = get_node("item_container")

func _ready():
	set_fixed_process(true)
	is_player = Globals.get("player") == self

func _fixed_process(delta):
	if !is_player:
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
	facing = new_dir

func get_facing():
	return facing

func take_damage(amount):
	if not can_take_damage:
		return
	can_take_damage = false
	get_node("Sprite").set_modulate(Color(0.8,0,0,1))
	var t = Timer.new()
	add_child(t)
	t.start()
	yield(t,"timeout")
	get_node("Sprite").set_modulate(Color(1,1,1,1))
	t.queue_free()
	can_take_damage = true