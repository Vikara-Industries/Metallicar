extends Node
#class_name Director


@export var StartingScene :PackedScene = LEVEL_1
var PauseMenu :Control
var LevelUpMenu :Control
@onready var CurrentMenu = PauseMenu
var CurrentScene :PackedScene
var CurrentSceneInstance :Node2D

const LEVEL_1 = preload("res://Scenes/Level1.tscn")
const LEVEL_2 = preload("res://Scenes/Level2.tscn")

enum scenes {LEVEL_1,LEVEL_2}



func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	changeScene(StartingScene,false)
	
func pauseGame(menu = 1):
	#pause menu = 1
	#Level up menu = 2
	if menu == 1:
		CurrentMenu = PauseMenu
		get_tree().paused =true
		PauseMenu.show()
	if menu == 2:
		CurrentMenu = LevelUpMenu
		get_tree().paused =true
		LevelUpMenu.displayMenu()
		
func resumeGame():
	get_tree().paused =false
	CurrentMenu.hide()
	CurrentMenu = PauseMenu
	
func playButton():
	if get_tree().paused:
		resumeGame()
	else:
		pauseGame()
		
func restartScene():
	changeScene(CurrentScene)
	
	
func changeScene(scene, destroy = true):
	if destroy:
		CurrentSceneInstance.queue_free()
	build_new_scene(scene)
	#call_deferred("build_new_scene", scene) 
	CurrentMenu = PauseMenu
	#pauseGame()
	
func build_new_scene(scene):
		CurrentScene = scene
		CurrentSceneInstance = CurrentScene.instantiate()
		get_node('/root/Stage').add_child(CurrentSceneInstance)
		CurrentSceneInstance.request_ready()
		
func _unhandled_input(event):
	if event is InputEventKey:
		if event.is_action_pressed("Pause") and CurrentMenu == PauseMenu:
			if get_tree().paused:
				resumeGame()
			else:
				pauseGame(1)
			


func _on_music_bar_value_changed(value):
	pass # Replace with function body.


func _on_sounds_bar_value_changed(value):
	pass # Replace with function body.


func _on_master_bar_value_changed(value):
	pass # Replace with function body.
