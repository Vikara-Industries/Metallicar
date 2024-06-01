extends Node2D
class_name Weapon

@export var weapontype : String
var level = 1
var max_level = 6

@onready var fireTimer : Timer = get_node("./FireTimer")

# Called when the node enters the scene tree for the first time.
func _ready():
	fireTimer.timeout.connect(on_fireTimer_timeout)

func canUpgrade():
	if level < max_level:
		return true
	else:
		return false

func upgrade():
	level += 1
	print(level)
	
func on_fireTimer_timeout():
	fire()
# Called every frame. 'delta' is the elapsed time since the previous frame.

func fire():
	print("Bang")
