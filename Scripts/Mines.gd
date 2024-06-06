extends Weapon

const MINE = preload("res://Scenes/Prefabs/Mine.tscn")
var damage = 7

func fire():
	var newmine = MINE.instantiate()
	newmine.damage = damage
	Director.CurrentSceneInstance.add_child(newmine)
	newmine.global_position = self.global_position

func upgrade():
	level+= 1
	match level:
		1:
			damage += 2
		2:
			fireTimer.wait_time = 2
		3:
			damage += 3
		4:
			damage += 4
		5:
			fireTimer.wait_time = 1
		6:
			damage += 5
