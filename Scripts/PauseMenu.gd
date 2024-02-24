extends Control


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
