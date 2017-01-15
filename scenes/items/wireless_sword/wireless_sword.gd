extends Node2D

onready var anim = get_node("anim")
var player
export (bool) var expendable = false
export (int) var max_stock
export (int) var current_stock

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

func _on_sword_body_enter( body ):
	if body.is_in_group("enemy"):
		body.take_damage(4)
