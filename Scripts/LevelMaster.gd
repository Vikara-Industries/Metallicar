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
var waves = [
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},

{"Bomber1":1},
#01:01
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},{"Walker1":1},
#02:01
{"Shooter1":1},{},{"Shooter1":1},{},{"Shooter1":1},{},
{"Shooter1":1},{},{"Shooter1":1},{},{"Shooter1":1},{},
{"Shooter1":1},{},{"Shooter1":1},{},{"Shooter1":1},{},
{"Shooter1":1},{},{"Shooter1":1},{},{"Shooter1":1},{},
{"Shooter1":1},{},{"Shooter1":1},{},{"Shooter1":1},{},

{"Bomber1":1},

{"Shooter1":1},{},{"Shooter1":1},{},{"Shooter1":1},{},
{"Shooter1":1},{},{"Shooter1":1},{},{"Shooter1":1},{},
{"Shooter1":1},{},{"Shooter1":1},{},{"Shooter1":1},{},
{"Shooter1":1},{},{"Shooter1":1},{},{"Shooter1":1},{},
{"Shooter1":1},{},{"Shooter1":1},{},{"Shooter1":1},{},
#3:02
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},

{"Bomber1":1},
#4:02
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},{"Walker2":1},
#5:02
{"Shooter2":1},{},{"Shooter2":1},{},{"Shooter2":1},{},
{"Shooter2":1},{},{"Shooter2":1},{},{"Shooter2":1},{},
{"Shooter2":1},{},{"Shooter2":1},{},{"Shooter2":1},{},
{"Shooter2":1},{},{"Shooter2":1},{},{"Shooter2":1},{},
{"Shooter2":1},{},{"Shooter2":1},{},{"Shooter2":1},{},

{"Bomber1":1},

{"Shooter2":1},{},{"Shooter2":1},{},{"Shooter2":1},{},
{"Shooter2":1},{},{"Shooter2":1},{},{"Shooter2":1},{},
{"Shooter2":1},{},{"Shooter2":1},{},{"Shooter2":1},{},
{"Shooter2":1},{},{"Shooter2":1},{},{"Shooter2":1},{},
{"Shooter2":1},{},{"Shooter2":1},{},{"Shooter2":1},{},
#6:03
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
#7:03
{"Bomber1":1},

{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},{"Walker3":1},
#8:03
{"Shooter3":1},{},{"Shooter3":1},{},{"Shooter3":1},{},
{"Shooter3":1},{},{"Shooter3":1},{},{"Shooter3":1},{},
{"Shooter3":1},{},{"Shooter3":1},{},{"Shooter3":1},{},
{"Shooter3":1},{},{"Shooter3":1},{},{"Shooter3":1},{},
{"Shooter3":1},{},{"Shooter3":1},{},{"Shooter3":1},{},

{"Bomber1":1},

{"Shooter3":1},{},{"Shooter3":1},{},{"Shooter3":1},{},
{"Shooter3":1},{},{"Shooter3":1},{},{"Shooter3":1},{},
{"Shooter3":1},{},{"Shooter3":1},{},{"Shooter3":1},{},
{"Shooter3":1},{},{"Shooter3":1},{},{"Shooter3":1},{},
{"Shooter3":1},{},{"Shooter3":1},{},{"Shooter3":1},{},

{"Bomber1":1}
#9:05
]


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
