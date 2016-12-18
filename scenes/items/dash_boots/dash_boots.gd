extends Node2D

var player
var walk_speed

onready var particles = get_node("particles")

func use():
	if player == null:
		player = Globals.get("player")
		walk_speed = player.WALK_SPEED
	player.WALK_SPEED = walk_speed * 1.3
	particles.set_emitting(true)
	
func release():
	player.WALK_SPEED = walk_speed
	particles.set_emitting(false)