extends Control

signal returnToGame
signal settingsSignal
signal resetSignal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_return_button_button_up() -> void:
	returnToGame.emit()

func _on_reset_button_button_up() -> void:
	resetSignal.emit()
	#unpause game here

func _on_settings_button_button_up() -> void:
	visible = false
	settingsSignal.emit()
	process_mode = Node.PROCESS_MODE_DISABLED

func _on_settings_back_signal() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = true

func _on_title_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
	#returnToGame.emit()
	#var rootNode = get_tree().root.get_child(1)
	#var title = ResourceLoader.load("res://scenes/title_screen.tscn")
	#var titleInst = title.instantiate()
	#get_tree().root.add_child(titleInst)
	#rootNode.free()
