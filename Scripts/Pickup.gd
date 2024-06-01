extends Area2D
class_name Pickup

var player: Player
func _ready():
	if player == null:
		player = get_tree().get_nodes_in_group("Player")[-1]
	connect("body_entered",on_body_entered)


func on_body_entered(body):
	if body == player:
		player.pickUp(self)
		queue_free()
