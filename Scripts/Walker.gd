extends CharacterBody2D
class_name Walker

#base class for enemies
@onready var animation_player = $AnimationPlayer
@onready var progress_bar = $ProgressBar
@onready var hp_display_timer = $HPDisplayTimer
@onready var death_particles = $DeathParticles
@onready var hurt_box = $HurtBox
@onready var attack_timer = $AttackTimer


const XP_PICKUP = preload("res://Scenes/Prefabs/XpPickup.tscn")
var xpDrop = 1
var dead = false

var hp = 10
var player :Player
var speed = 50
var crashVel : Vector2
@export var attackReady = false
@export var damage = 2
@export var friction = 65
# Called when the node enters the scene tree for the first time.
func _ready():
	if player == null:
		player = get_tree().get_first_node_in_group("Player")
	progress_bar.max_value = hp
	
var playerInHurtbox = false
var distanceToPlayer
var attackRange = 65
var teleportThresholdDistance = 1000
var col

func _physics_process(delta):
	if not dead:
		distanceToPlayer = (player.global_position - self.global_position).length()
		look_at(player.position)
		if distanceToPlayer > teleportThresholdDistance:
			self.global_position = player.get_node("./spawners").get_children()[randi_range(0,3)].global_position
		if crashVel.length() < 60 and attack_timer.is_stopped():
			velocity = (player.global_position - self.global_position).normalized() * speed
		else:
			velocity = crashVel
			crashVel /= friction *delta
		move_and_slide()

func takeDamage(num):
	if not dead:
		hp -= num
		if hp <= 0:
			die()
		
		progress_bar.show()
		progress_bar.value = hp
		hp_display_timer.start()
	
func die():
	set_collision_layer_value(1,false)
	set_collision_mask_value(1,false)
	dead = true
	death_particles.restart()
	await death_particles.finished
	var pickup = XP_PICKUP.instantiate()
	pickup.value = xpDrop
	pickup.global_position = self.global_position
	get_parent().add_child(pickup)
	queue_free()

func _on_hp_display_timer_timeout():
	progress_bar.hide()


func _on_hurt_box_body_entered(body):
	attack_timer.start()
	animation_player.play("attack")
	velocity = Vector2.ZERO

func _on_attack_timer_timeout():
	animation_player.play("RESET")
	for body in hurt_box.get_overlapping_bodies():
		if body.is_in_group("Player"):
			body.takeDamage(damage)
			attack_timer.start()
