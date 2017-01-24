extends StaticBody2D

func _init():
	add_to_group("cracked_wall")

func _ready():
	pass

func destroy():
	MUSIC.resume_dungeon_music(true)
	MUSIC.start_play("uat")
	queue_free()