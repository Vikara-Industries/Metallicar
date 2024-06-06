extends Weapon
class_name Machinegun

@onready var ray_cast: RayCast2D= $RayCast2D
@onready var particles: CPUParticles2D = $CPUParticles2D

var damage = 15

func fire():
	ray_cast.force_raycast_update()
	particles.emitting = true
	var hit = ray_cast.get_collider()
	if hit and hit.has_method("takeDamage"):
		hit.takeDamage(damage)
	
func upgrade():
	level+= 1
	match level:
		1:
			damage += 5
		2:
			fireTimer.wait_time = 0.1
		3:
			damage += 5
		4:
			damage += 5
		5:
			damage += 5
		6:
			damage += 5
