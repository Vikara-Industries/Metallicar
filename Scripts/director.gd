extends Node
#class_name Director


@export var StartingScene :PackedScene = preload("res://Scenes/Level1.tscn")
var PauseMenu :Control
var CurrentScene :Node2D


const LEVEL_1 = preload("res://Scenes/Level1.tscn")
const LEVEL_2 = preload("res://Scenes/Level2.tscn")

enum scenes {LEVEL_1,LEVEL_2}

@onready var camera: Camera2D= $Camera2D


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	CurrentScene = StartingScene.instantiate()
	add_child(CurrentScene)
	pauseGame()
	
func pauseGame():
	get_tree().paused =true
	PauseMenu.show()
	
func resumeGame():
	get_tree().paused =false
	PauseMenu.hide()
	
func playButton():
	if get_tree().paused:
		resumeGame()
	else:
		pauseGame()
func restartScene():
	CurrentScene.queue_free()
	CurrentScene = StartingScene.instantiate()
	add_child(CurrentScene)
	
	
func changeScene(scene, destroy = false):
	if destroy:
		CurrentScene.queue_free()
	CurrentScene = scene.instantiate()
	add_child(CurrentScene)
func _unhandled_input(event):
	if event is InputEventKey:
		if event.is_action_pressed("Pause"):
			if get_tree().paused:
				resumeGame()
			else:
				pauseGame()

			


func _on_music_bar_value_changed(value):
	pass # Replace with function body.


func _on_sounds_bar_value_changed(value):
	pass # Replace with function body.


func _on_master_bar_value_changed(value):
	pass # Replace with function body.
