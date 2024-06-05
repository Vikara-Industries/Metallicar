extends Weapon

@onready var particles: CPUParticles2D = $Particles
@onready var fire_timer = $FireTimer
@onready var anim_timer = $AnimTimer
@onready var aim :AnimatedSprite2D = $blastArea/aim

@onready var blast_area = $blastArea
@export var maxRange = 300
@export var damage = 30
func fire():
	particles.global_position = blast_area.global_position
	particles.emitting = true
	for body in blast_area.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			body.takeDamage(damage)
	blast_area.position = Vector2.UP.rotated(randf_range(0,3)) * randf_range(10,maxRange)
	
func upgrade():
	level += 1
	match level:
		1:
			damage +=5
		2:
			damage +=5
		3:
			fire_timer.wait_time = 1.5
			anim_timer.wait_time = fire_timer.wait_time/4
			anim_timer.start()
			fire_timer.start()
		4:
			damage += 5
		5:
			fire_timer.wait_time = 1
			anim_timer.wait_time = fire_timer.wait_time/4
			anim_timer.start()
			fire_timer.start()
		6:
			damage += 10


func _on_anim_timer_timeout():
	if aim.get_frame() >= 3:
		aim.set_frame(0)
	else:
		aim.set_frame(aim.get_frame() + 1)
