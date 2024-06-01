extends Node
class_name LevelMaster

var player :Player

var weaponList = [preload("res://Scenes/Prefabs/Shotgun.tscn").instantiate(),
preload("res://Scenes/Prefabs/SawBlade.tscn").instantiate(),
preload("res://Scenes/Prefabs/Missle.tscn").instantiate()]
const HEALTH_PACK = preload("res://Scenes/Prefabs/healthPack.tscn")

var levelTime : int #in seconds
var EnemySpawners = []
@onready var WaveTimer = $waveTimer

@onready var level_timer = $levelTimer
var waves = [{"Walker1":5},{"Walker1":10},{"Walker2":10},{"Walker2":20},{"Walker1":50, "Walker2":20},
{"Shooter1":5},{"Walker2":40},{"Walker3":10, "Shooter1":5},{"Walker2":30},{"Walker3":30},
{"Walker2":30,"Walker1":40,"Walker3":10, "Shooter1":10}]
var waveIndex = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for spawner in get_node("../Player/spawners").get_children():
		EnemySpawners.append(spawner)
	player = get_tree().get_nodes_in_group("Player")[-1]

signal levelUpResolved

func resolveLvlUp(choice):
	if choice is Weapon:
		if player.can_add_weapon(choice):
			player.add_weapon(choice)
			emit_signal("levelUpResolved")
			return

	if choice == "hp":
		var hp = HEALTH_PACK.instantiate()
		hp.global_position = player.global_position
		get_parent().add_child(hp)
		emit_signal("levelUpResolved")
	
func spawnEnemies(wave):
	for spawner in EnemySpawners:
		spawner.spawnWave(wave)
		
func _unhandled_input(event):
	if event is InputEventKey and event.keycode == KEY_SPACE:
		_on_wave_timer_timeout()

func _on_wave_timer_timeout():
	if waveIndex < waves.size():
		spawnEnemies(waves[waveIndex])
		waveIndex += 1
