extends Control
@onready var animation_player = $AnimationPlayer

var music_bus = AudioServer.get_bus_index("Music")
var sound_bus = AudioServer.get_bus_index("Sound")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _enter_tree():
	Director.PauseMenu = self
	

func _on_play_button_button_up():
	Director.playButton()

func _on_restart_button_button_up():
	Director.restartScene()

func _on_quit_button_button_up():
	if Director.CurrentScene == Director.LEVEL_1:
		Director.changeScene(Director.LEVEL_2)
	else:
		Director.changeScene(Director.LEVEL_1)


func _on_music_slider_value_changed(value):
	if value == -30:
		AudioServer.set_bus_mute(music_bus,true)
		animation_player.play("jumpscare")
	else:
		AudioServer.set_bus_mute(music_bus,false)
		AudioServer.set_bus_volume_db(music_bus,value)


func _on_sfx_slider_value_changed(value):
	if value == -30:
		AudioServer.set_bus_mute(music_bus,true)
	else:
		AudioServer.set_bus_mute(music_bus,false)
		AudioServer.set_bus_volume_db(music_bus,value)
