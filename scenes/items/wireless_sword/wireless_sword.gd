extends Node2D

onready var anim = get_node("anim")
var player

func use():
	if anim.is_playing(): return
	if player == null:
		player = Globals.get("player")
	if player.is_fixed_processing():
		player.set_fixed_process(false)
		anim.play("attack")
		yield (anim, "finished")
		player.set_fixed_process(true)

func release():
	pass