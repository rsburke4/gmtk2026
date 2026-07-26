extends CanvasLayer
class_name LoseScreen

var child

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var paused = get_tree().paused
	visible = paused
	child = get_child(0)
	child.process_mode = Node.PROCESS_MODE_DISABLED
	loseSet(false)
	
func toggleLose():
	var paused = !get_tree().paused
	get_tree().paused = paused
	visible = paused
	if(!paused):
		child.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		child.process_mode = Node.PROCESS_MODE_ALWAYS
	
func loseSet(paused: bool):
	get_tree().paused = paused
	visible = paused
	if(!paused):
		child.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		child.process_mode = Node.PROCESS_MODE_ALWAYS
	var p = get_parent() as MainScene
