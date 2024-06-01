extends Weapon

@onready var fire_timer = $FireTimer
@onready var blast_area = $blastArea
@export var maxRange = 300
@export var damage = 30
func fire():
	blast_area.position = Vector2.UP.rotated(randf_range(0,3)) * randf_range(10,maxRange) 
	for body in blast_area.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			body.takeDamage(damage)

func upgrade():
	level += 1
	match level:
		1:
			damage +=5
		2:
			damage +=5
		3:
			fire_timer.wait_time = 1.5
		4:
			damage += 5
		5:
			fire_timer.wait_time = 1
		6:
			damage += 10
