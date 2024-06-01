extends AudioStreamPlayer

var songs = []
var songIter = 0
func _ready():
	songs.append(load("res://audio/vehicular_godslaughter.mp3"))

func _on_finished():
	
	if songIter+1 < songs.size():
		songIter += 1
	else:
		songIter = 0
	set_stream(songs[songIter])
	play()
