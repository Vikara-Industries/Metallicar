extends Area2D
class_name EnemySpawner

func canSpawn():
	for area in get_overlapping_areas():
		if area is PlayArea:
			return true
	return false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
