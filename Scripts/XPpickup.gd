extends Pickup
class_name XPpickup

@export var speed = 300
@export var range = 150

var value = 1

func _physics_process(delta):
	if abs((- player.global_position + self.global_position).length()) < range:
		var direction = (player.global_position - global_position).normalized()
		move_local_x(direction.x * delta *speed)
		move_local_y(direction.y * delta *speed)
