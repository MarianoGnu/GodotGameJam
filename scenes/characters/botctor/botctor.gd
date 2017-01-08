extends "res://scenes/characters/character.gd"

const STATE_PATROLL = 0
const STATE_ATTACK  = 1

var state = STATE_PATROLL setget set_state,get_state
var player

onready var patroll_timer = get_node("patroll_timer")

func _init():
	add_to_group("enemy")

func _ready():
	patroll_timer.connect("timeout",self,"update_patroll")

func get_state():
	return state

func update_patroll():
	if dir.length_squared() == 0:
		set_facing(randi() % 4)
		if facing == UP:
			dir = Vector2(0,-1)
		elif facing == DOWN:
			dir = Vector2(0,1)
		elif facing == LEFT:
			dir = Vector2(-1,0)
		elif facing == RIGHT:
			dir = Vector2(1,0)
	else:
		dir = Vector2()

func set_state(new_state):
	if new_state == state:
		return
	
	state = new_state
	if state == STATE_PATROLL:
		patroll_timer.stop()
	else:
		patroll_timer.start()

func _on_hot_area_body_exit( body ):
	if body.is_in_group("player"):
		set_state(STATE_PATROLL)


func _on_attack_trigger_body_enter( body ):
	if body.is_in_group("player"):
		set_state(STATE_ATTACK)
		player = body
