extends Area2D
class_name EnemySpawner

const shooter1 = preload("res://Scenes/Prefabs/Shooter.tscn")
const walker1 =preload("res://Scenes/Prefabs/Walker.tscn")
func canSpawn():
	for area in get_overlapping_areas():
		if area is PlayArea:
			return true
	return false

var TargetParent
func _ready():
	#i am very sorry for the following line
	TargetParent = get_parent().get_parent().get_parent()

func spawnWave(wave: Dictionary):
	var iter = 0
	if wave.has("Walker1"):
		for walker in wave["Walker1"]:
			var newEnemy = walker1.instantiate()
			TargetParent.add_child(newEnemy)
			newEnemy.global_position = self.global_position - Vector2(iter,10)
			iter += 1
	if wave.has("Walker2"):
		for walker in wave["Walker2"]:
			var newEnemy = walker1.instantiate()
			newEnemy.hp *= 2
			newEnemy.speed *= 1.5
			newEnemy.xpDrop = 3
			newEnemy.get_node("./Sprite2D").set_texture(load("res://Art/Walker2.png")) 
			#i am very sorry for the following line
			TargetParent.add_child(newEnemy)
			newEnemy.global_position = self.global_position - Vector2(iter*5,10)
			iter += 1
	if wave.has("Walker3"):
		for walker in wave["Walker3"]:
			var newEnemy = walker1.instantiate()
			newEnemy.hp *= 6
			newEnemy.speed *= 4
			newEnemy.xpDrop = 10
			newEnemy.get_node("./Sprite2D").set_texture(load("res://Art/Walker3.png")) 
			#i am very sorry for the following line
			TargetParent.add_child(newEnemy)
			newEnemy.global_position = self.global_position - Vector2(10,iter*5)
			iter += 1
	if wave.has("Shooter1"):
		for shooter in wave["Shooter1"]:
			var newEnemy = shooter1.instantiate()
			TargetParent.add_child(newEnemy)
			newEnemy.global_position = self.global_position - Vector2(iter,10)
			iter += 1
	if wave.has("Shooter2"):
		for shooter in wave["Shooter2"]:
			var newEnemy = shooter1.instantiate()
			newEnemy.hp *= 2
			newEnemy.speed *= 1.5
			newEnemy.xpDrop = 50
			newEnemy.get_node("./Sprite2D").set_texture(load("res://Art/Shooter2.png"))
			TargetParent.add_child(newEnemy)
			newEnemy.global_position = self.global_position - Vector2(iter,10)
			iter += 1
	if wave.has("Shooter3"):
		for shooter in wave["Shooter3"]:
			var newEnemy = shooter1.instantiate()
			newEnemy.hp *= 2.5
			newEnemy.speed *= 2
			newEnemy.xpDrop = 100
			newEnemy.get_node("./Sprite2D").set_texture(load("res://Art/Shooter3.png"))
			TargetParent.add_child(newEnemy)
			newEnemy.global_position = self.global_position - Vector2(iter,10)
			iter += 1

