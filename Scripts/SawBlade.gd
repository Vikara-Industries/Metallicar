extends Weapon
class_name SawBlade

@onready var damage_area = $DamageArea
@export var damage = 1

func fire():
	for body in damage_area.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			body.takeDamage(damage)
			body.velocity = Vector2.ZERO

func upgrade():
	level += 1
	match level:
		1:
			damage += 1
		2:
			var bonusblade = preload("res://Scenes/Prefabs/SawBlade.tscn").instantiate()
			bonusblade.weapontype = "sawblade_2"
			get_parent().get_parent().add_weapon(bonusblade)
		3:
			damage += 1
		4:
			damage += 1
		5:
			var bonusblade = preload("res://Scenes/Prefabs/SawBlade.tscn").instantiate()
			bonusblade.weapontype = "sawblade_3"
			get_parent().get_parent().add_weapon(bonusblade)
		6:
			damage += 3
