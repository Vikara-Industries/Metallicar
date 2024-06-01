extends Pickup
class_name XPpickup

@export var speed = 3
@export var range = 150

var value = 1

func _physics_process(delta):
	if abs((- player.global_position + self.global_position).length()) < range:
		move_local_x((player.global_position.x - global_position.x) * delta *speed)
		move_local_y((player.global_position.y - global_position.y) * delta *speed)
