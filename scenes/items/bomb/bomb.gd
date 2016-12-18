extends Node2D

export(PackedScene) var bomb_scene

var player

func use():
	if player == null:
		player = Globals.get("player")
	var b = bomb_scene.instance()
	player.get_parent().add_child(b)
	b.set_global_pos(player.get_global_pos())

func release():
	pass
	
