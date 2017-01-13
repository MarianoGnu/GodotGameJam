extends Node

onready var player = get_parent()

func _ready():
	set_pause_mode(PAUSE_MODE_PROCESS)
	set_process_input(true)

func _input(event):
	player.dir = Vector2()
	if Input.is_action_pressed("ui_up"):
		player.dir.y -= 1
	if Input.is_action_pressed("ui_down"):
		player.dir.y += 1
	if Input.is_action_pressed("ui_left"):
		player.dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		player.dir.x += 1
	player.dir = player.dir.normalized()