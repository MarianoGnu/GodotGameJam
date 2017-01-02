extends StreamPlayer

var music = {
"got item": preload("res://audio/music/Got item.ogg"),
"intro": preload("res://audio/music/intro.ogg")
}

func _ready():
	pass


func start_play(song):
	if music.has(song):
		print("PLAY SONG")
		set_stream(music[song])
		print(typeof(music[song]))
		play()