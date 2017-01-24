extends KinematicBody2D

func _init():
	pass

func _ready():
	add_to_group("cracked_wall")
	pass

func destroy():
	print("DESTROYING WALL")
	MUSIC.resume_dungeon_music(true)
	MUSIC.start_play("uat")
	queue_free()