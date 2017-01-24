extends Node2D
var player

export(PackedScene) var bomb_scene
export (bool) var expendable = true
export (int) var max_stock = 20
export (int) var current_stock = 6

func _init():
	Globals.set("bomb", self)

func _ready():
	expendable = true
func use():
	if player == null:
		player = Globals.get("player")
	var b = bomb_scene.instance()
	player.get_parent().add_child(b)
	b.set_global_pos(player.get_global_pos())
	
func release():
	pass
	
