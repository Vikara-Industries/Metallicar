extends Area2D

@onready var timer = $Timer
@onready var animation_player = $AnimationPlayer
@onready var particles = $Particles

var damage 

func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		disconnect("body_entered",_on_body_entered)
		timer.start()
		animation_player.play("RESET")

func _on_timer_timeout():
	particles.emitting = true
	for body in get_overlapping_bodies():
		if body.has_method("takeDamage"):
			body.takeDamage(damage)
	await particles.finished
	queue_free()
