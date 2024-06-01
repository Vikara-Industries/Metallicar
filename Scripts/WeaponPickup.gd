extends Pickup
class_name WeaponPickup

@export var type:String = "shotgun"

var weapon
var shotgun = preload("res://Scenes/Prefabs/Shotgun.tscn")
var sawblade = preload("res://Scenes/Prefabs/SawBlade.tscn")
var missle = preload("res://Scenes/Prefabs/Missle.tscn")
func get_weapon():
	match type:
		"shotgun":
			weapon = shotgun
		"sawblade":
			weapon = sawblade
		"missle":
			weapon = missle
	return weapon.instantiate()
