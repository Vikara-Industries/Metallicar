extends AudioStreamPlayer

const BANONANONANO = preload("res://audio/banonanonano.mp3")
const PROJECT_3 = preload("res://audio/Project_3.mp3")
const VEHICULAR_GODSLAUGHTER = preload("res://audio/vehicular_godslaughter.mp3")
var songs = [PROJECT_3,VEHICULAR_GODSLAUGHTER,BANONANONANO]
var songIter = 0

func _ready():
	set_stream(songs[songIter])
	play()
	
func _on_finished():
	
	if songIter+1 < songs.size():
		songIter += 1
	else:
		songIter = 0
	set_stream(songs[songIter])
	play()
