extends CanvasLayer
class_name WinScreen
@onready var time: Label = $Control/VBoxContainer/Time

var child

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var paused = get_tree().paused
	visible = paused
	child = get_child(0)
	child.process_mode = Node.PROCESS_MODE_DISABLED
	winSet(false)

func toggleWin():
	var paused = !get_tree().paused
	get_tree().paused = paused
	visible = paused
	if(!paused):
		child.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		child.process_mode = Node.PROCESS_MODE_ALWAYS
	
func winSet(paused: bool):
	get_tree().paused = paused
	visible = paused
	if(!paused):
		child.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		child.process_mode = Node.PROCESS_MODE_ALWAYS
	var p = get_parent() as MainScene
	var time_elapsed = p.time_elapsed
	time.text = "in " + str(time_elapsed).pad_decimals(2) +"s"
