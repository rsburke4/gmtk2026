extends Control

signal returnToGame
signal settingsSignal
signal resetSignal
signal resetLevelSignal
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func click():
	audio_stream_player_2d.play()

func _on_return_button_button_up() -> void:
	click()
	returnToGame.emit()

func _on_reset_button_button_up() -> void:
	click()
	resetSignal.emit()
	#unpause game here

func _on_settings_button_button_up() -> void:
	click()
	visible = false
	settingsSignal.emit()
	process_mode = Node.PROCESS_MODE_DISABLED

func _on_settings_back_signal() -> void:
	click()
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = true

func _on_title_button_button_up() -> void:
	click()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")


func _on_reset_button_2_button_up() -> void:
	click()
	resetLevelSignal.emit()
