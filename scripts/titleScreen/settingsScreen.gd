extends Control

@export var controlNode: Control
@export var Song1: AudioStreamPlayer
@export var Song2: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func _on_back_button_button_up() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	controlNode.process_mode = Node.PROCESS_MODE_ALWAYS
	controlNode.visible = true

func _on_check_box_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	if(not toggled_on):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_music_slider_value_changed(value: float) -> void:
	Globals.musicVolume = value
	var musicBusIndex = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(musicBusIndex, linear_to_db(value))

func _on_sfx_slider_value_changed(value: float) -> void:
	var sfxBusIndex = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(sfxBusIndex, linear_to_db(value))
