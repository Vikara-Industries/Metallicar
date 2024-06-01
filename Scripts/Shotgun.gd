extends Weapon
class_name Shotgun

@export var damage = 3
@onready var raycasts = [$RayCast2D, $RayCast2D2, $RayCast2D3, $RayCast2D4, $RayCast2D5, $RayCast2D6, $RayCast2D7, $RayCast2D8, $RayCast2D9, $RayCast2D10]
@onready var cpu_particles_2d = $CPUParticles2D

func upgrade():
	level += 1
	match level:
		1:
			damage +=1
		2:
			damage +=2
		3:
			var bonusshotgun = preload("res://Scenes/Prefabs/Shotgun.tscn").instantiate()
			bonusshotgun.weapontype = "bonus_shotgun"
			get_parent().get_parent().add_weapon(bonusshotgun)
		4:
			damage += 1
		5:
			damage += 1
		6:
			damage += 2
			
func fire():
	cpu_particles_2d.restart()
	for cast : RayCast2D in raycasts:
		cast.force_raycast_update()
		request_ready()
		if is_instance_valid(cast.get_collider()) and cast.is_colliding():
			
			if cast.get_collider().has_method("takeDamage"):
				cast.get_collider().takeDamage(damage)
