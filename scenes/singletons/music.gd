extends StreamPlayer

var music = {"got item": preload("res://audio/music/Got item.ogg")}

func _ready():
#	start_play("got item")
	pass


func start_play(song):
	if music.has(song):
		print("PLAY SONG")
		set_stream(music[song])
		print(typeof(music[song]))
		play()