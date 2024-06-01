extends RichTextLabel

@onready var level_timer = $"../../../LevelMaster/levelTimer"
var timeString :String
var buffer
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	buffer = level_timer.time_left
	var minutes = int(buffer/60)
	var seconds = int(100 * (buffer/60 - int(buffer/60))/1.66)
	timeString = str(minutes)+":"+str(seconds)
	text = timeString
