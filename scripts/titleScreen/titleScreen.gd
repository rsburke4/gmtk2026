extends Control

@export var settingsScreen: Control

var level1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level1 = ResourceLoader.load("res://scenes/Level1.tscn")
	settingsScreen.visible = false
	settingsScreen.process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_button_button_up() -> void:
	var level1Inst = level1.instantiate()
	get_tree().root.add_child(level1Inst)
	get_parent().queue_free()

func _on_quit_button_button_up() -> void:
	get_tree().quit()

func _on_settings_button_button_up() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	settingsScreen.process_mode = Node.PROCESS_MODE_ALWAYS
	settingsScreen.visible = true
	
