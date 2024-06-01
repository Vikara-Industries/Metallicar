extends CharacterBody2D
class_name Player
@export var hp = 100
@export var MAX_WEAPONS = 3

@onready var xp_bar = $UI/Control/xpBar
@onready var hp_bar = $UI/Control/hpBar

func _ready():
	xp_bar.value = xp
	xp_bar.max_value = xpToNextLevel
	
	hp_bar.max_value = hp
	hp_bar.value = hp

@export var wheel_base = 70
@export var steering_angle = 15
@export var engine_power = 1000
@export var friction = -55
@export var drag = -0.06
@export var braking = -450
@export var max_speed_reverse = 250
@export var slip_speed = 200
@export var traction_fast = 2.5
@export var traction_slow = 10
@onready var animation_player = $AnimationPlayer

var realVelocity : Vector2
var acceleration = Vector2.ZERO
var steer_direction

@onready var door_left = $DoorLeft
@onready var door_right = $DoorRight
@onready var front_left = $FrontLeft
@onready var front_right = $FrontRight
@onready var back_middle = $BackMiddle
@onready var top = $Top


#level threshold 
var xp = 0
var xpToNextLevel = xp*xp + 5

var weapons = []

func getXp(num = 1):
	
	for i in num:
		xp += 1
		
		if xp >= xpToNextLevel:
			xpToNextLevel = xp*1.5 + 15
			levelUp()
			await get_tree().get_first_node_in_group("LevelMaster").levelUpResolved
	xp_bar.value = xp
	
func levelUp():
	print(xpToNextLevel - xp)
	xp_bar.min_value = xp
	xp_bar.max_value = xpToNextLevel
	Director.pauseGame(2)
 
#var col
func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction(delta)
	calculate_steering(delta)
	velocity += acceleration * delta
	
	realVelocity = readSpedometer(delta)
	
	#col = move_and_collide(velocity*delta)
	move_and_slide()
	
func pickUp(item : Pickup):
	if item is HealthPack:
		hp += item.value
		hp_bar.value = hp
		print(hp)
	if item.has_method('get_weapon'):
		if can_add_weapon(item.get_weapon()):
			add_weapon(item.get_weapon())
	if item is XPpickup:
		getXp(item.value)

func can_add_weapon(weapon :Weapon):
	for w in weapons:
		if weapon.weapontype == w.weapontype:
			if w.canUpgrade():
				return true
			else:
				return false
	if weapons.size() <= MAX_WEAPONS:
		return true
	return false
	
func add_weapon(weapon :Weapon):
	for w in weapons:
		if weapon.weapontype == w.weapontype:
			w.upgrade()
			return
	match weapon.weapontype:
		"shotgun":
			door_left.add_child(weapon) 
			weapons.append(weapon)
		"bonus_shotgun":
			door_right.add_child(weapon)
		"sawblade":
			back_middle.add_child(weapon)
			weapons.append(weapon)
		"sawblade_2":
			front_left.add_child(weapon)
		"sawblade_3":
			front_right.add_child(weapon)
		"missle":
			top.add_child(weapon)
			weapons.append(weapon)

func get_weapons():
	return weapons.duplicate()
	
func takeDamage(num):
	animation_player.play("dmg")
	animation_player.animation_set_next("dmg","RESET")
	hp -= num
	hp_bar.value = hp
	if hp <= 0:
		die()
		
func die():
	queue_free()
	Director.restartScene()
	

@onready var previousPos = global_position

func readSpedometer(delta):
	var distanceTraveled = global_position - previousPos 
	previousPos = global_position
	return distanceTraveled/delta
	
func apply_friction(delta):
	if acceleration == Vector2.ZERO and velocity.length() < 50:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction * delta
	var drag_force = velocity * velocity.length() * drag * delta
	acceleration += drag_force + friction_force
	
func get_input():
	var turn = Input.get_axis("steer_left", "steer_right")
	steer_direction = turn * deg_to_rad(steering_angle)
	if Input.is_action_pressed("accelerate"):
		acceleration = transform.x * engine_power
	if Input.is_action_pressed("brake"):
		acceleration = transform.x * braking
	
func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base / 2.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	var new_heading = rear_wheel.direction_to(front_wheel)
	var traction = traction_slow
	if velocity.length() > slip_speed:
		traction = traction_fast
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = lerp(velocity, new_heading * velocity.length(), traction * delta)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
#	velocity = new_heading * velocity.length()
	rotation = new_heading.angle()


func _on_hurt_box_body_entered(body):
	if body.is_in_group("Enemy"):
		body.crashVel = 2* realVelocity
		body.takeDamage(body.crashVel.length()/100)
