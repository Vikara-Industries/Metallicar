extends CharacterBody2D
class_name EnemyCar

var GlobalTagretPos: Vector2 = Vector2.ZERO
@export var maxSpeed = 500
var targetDistance = 50
var crashVel
@onready var player = get_tree().get_nodes_in_group("Player")[-1]
var teleportThresholdDistance = 1300

var prepVel
func _physics_process(delta):
	GlobalTagretPos = player.global_position - Vector2(0,100).rotated(player.rotation)
	look_at(GlobalTagretPos)
	var distanceVector =  GlobalTagretPos - global_position
	
	if distanceVector.length() > teleportThresholdDistance:
		self.global_position = player.get_node("./spawners").get_children()[randi_range(0,3)].global_position 
	elif distanceVector.length() >= targetDistance:
		velocity = distanceVector.normalized() * maxSpeed
	
	
	
	
	var col = move_and_collide(velocity * delta)
	if col != null and col.get_collider().is_in_group("Enemy"):
		if randf() > 0.5:
			col.get_collider().crashVel = velocity.rotated(1.5) * 2
		else:
			col.get_collider().crashVel = velocity.rotated(-1.5) * 2

func takeDamage(dmg):
	pass
