extends Control

var lvlMaster 
@onready var buttons = [$"Option 1", $"Option 2", $"Option 3"]


func _ready():
	Director.LevelUpMenu = self
	lvlMaster = get_parent().get_parent()
	connect("LevelUp",lvlMaster.resolveLvlUp)


signal LevelUp

func displayMenu():
	generateOptions()
	self.show()

var options :Array

func generateOptions():
	options = []
	var availableWeapons :Array = lvlMaster.weaponList.duplicate()
	
	for i in range(1,4):
		while options.size() < i:
			if availableWeapons.size() < 1:
				options.append("hp")
			else:
				
				var index = randi_range(0,availableWeapons.size()-1)
				if lvlMaster.player.can_add_weapon(availableWeapons[index]):
					options.append(availableWeapons[index])
					
				availableWeapons.remove_at(index)
	for i in range(0,3):
		if options[i] is Weapon:
			buttons[i].text = options[i].weapontype
		else:
			buttons[i].text = options[i]
			
func _on_option1():
	Director.resumeGame()
	emit_signal("LevelUp", options[0])
	
func _on_option2():
	Director.resumeGame()
	emit_signal("LevelUp", options[1])
	
func _on_option3():
	Director.resumeGame()
	emit_signal("LevelUp", options[2])
