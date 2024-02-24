extends CharacterBody2D
class_name Emeny
#base class for enemies


var player
@export var maxSpeed :int

# Called when the node enters the scene tree for the first time.
func _ready():
	if player == null:
		get_tree().get_first_node_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	moveToPlayer()
func moveToPlayer()
