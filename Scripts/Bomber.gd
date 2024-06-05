extends CharacterBody2D
class_name Bomber

@onready var blast_area = $blastArea
@onready var animation_player = $AnimationPlayer
@onready var blast_shape = $blastArea/BlastShape

var player :Player
var speed = 400
var top_speed = 600
var dmg = 10
var crashVel :Vector2 = Vector2.ZERO
var friction = 80

func _ready():
	if player == null:
		player = get_tree().get_first_node_in_group("Player")
	animation_player.set_current_animation("Chasing")
	animation_player.queue("Detonating")
	
@export var dead = false
var col
func _physics_process(delta):
	if is_instance_valid(player):
		if animation_player.current_animation == "Chasing":
			look_at(player.position)
			
			if crashVel.length() < 60:
				velocity = (player.global_position - self.global_position).normalized() * speed
			else:
				velocity = crashVel
				crashVel /= friction *delta
			col = move_and_collide(velocity * delta)
			if col != null and col.get_collider().is_in_group("Enemy"):
				if randf() > 0.5:
					col.get_collider().crashVel = velocity.rotated(1.5)
				else:
					col.get_collider().crashVel = velocity.rotated(-1.5)
				
		else:
			for body in blast_area.get_overlapping_bodies():
				if body.has_method("takeDamage"):
					body.takeDamage(dmg*delta)
	if dead:
		queue_free()
func takeDamage(num):
	pass
	
func _on_animation_player_animation_changed(old_name, new_name):
	
	if old_name == "Detonating":
		queue_free()

