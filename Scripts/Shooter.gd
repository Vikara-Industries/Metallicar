extends CharacterBody2D
class_name Shooter

@onready var animation_player = $AnimationPlayer
@onready var progress_bar = $ProgressBar
@onready var hp_display_timer = $HPDisplayTimer
@onready var death_particles = $DeathParticles
@onready var react_timer = $ReactTimer

const XP_PICKUP = preload("res://Scenes/Prefabs/XpPickup.tscn")
var xpDrop = 1
var dead = false

@onready var reload_timer = $ReloadTimer

var hp = 10
var player :Player
var speed = 200
var crashVel : Vector2
@export var attackReady = false
@export var damage : float = 0.5

@export var friction = 65

const BULLET := preload("res://Scenes/Prefabs/Bullet.tscn")

func _ready():
	if player == null:
		player = get_tree().get_first_node_in_group("Player")
	progress_bar.max_value = hp
	
var playerInHurtbox = false
var distanceToPlayer
var attackRange = 350
var teleportThresholdDistance = 1000
var col


func _physics_process(delta):
	if not dead:
		distanceToPlayer = (player.global_position - self.global_position).length()
		look_at(player.position)
		if distanceToPlayer > teleportThresholdDistance:
			self.global_position = player.get_node("./spawners").get_children()[randi_range(0,3)].global_position
		
		if attackReady and distanceToPlayer <= attackRange:
			
			shootAt((player.global_position - global_position)+ player.velocity.normalized() * player.realVelocity *delta)
			attackReady = false
			animation_player.play("RESET")
		if crashVel.length() < 50:
			
			if distanceToPlayer > attackRange:
				velocity = (player.global_position - self.global_position).normalized() * speed
			elif react_timer.is_stopped():
				react_timer.start()
				velocity = player.velocity.normalized() * speed 
		else:
			velocity = crashVel
			crashVel /= friction *delta
		
		move_and_collide(velocity*delta)
		

func shootAt(pos :Vector2):
	var newBullet = BULLET.instantiate()
	newBullet.global_position = global_position
	newBullet.direction = pos
	newBullet.dmg = damage
	get_parent().get_parent().add_child(newBullet)
	
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


func _on_reload_timer_timeout():
	attackReady = true
