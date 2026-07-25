extends CanvasLayer

var child

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var paused = get_tree().paused
	visible = paused
	child = get_child(0)
	child.process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("pause"):
		var paused = !get_tree().paused
		get_tree().paused = paused
		visible = paused
		if(paused):
			child.process_mode = Node.PROCESS_MODE_DISABLED
		else:
			child.process_mode = Node.PROCESS_MODE_ALWAYS
