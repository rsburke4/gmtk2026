extends Control

@export var settingsScreen: Control
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"

var level1
signal settingsSignal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level1 = ResourceLoader.load("res://scenes/MainScene.tscn")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func click():
	audio_stream_player_2d.play()

func _on_start_button_button_up() -> void:
	#var level1Inst = level1.instantiate()
	#get_tree().root.add_child(level1Inst)
	#get_parent().queue_free()
	click()
	get_tree().change_scene_to_file("res://scenes/MainScene.tscn")

func _on_quit_button_button_up() -> void:
	click()
	get_tree().quit()

func _on_settings_button_button_up() -> void:
	click()
	visible = false
	settingsSignal.emit()
	
func _on_settings_back_signal() -> void:
	click()
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = true
