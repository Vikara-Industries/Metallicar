extends Area2D
@onready var timer = $Timer

var dmg = 5
var direction: Vector2
var speed = 500

func _ready():
	look_at(direction)
	
func _physics_process(delta):
	global_position += direction.normalized() * speed *delta
	
func _on_body_entered(body):
	if body.is_in_group("Player") and body.has_method("takeDamage"):
		body.takeDamage(dmg)
		queue_free()


func _on_timer_timeout():
	queue_free()
