extends Node2D
class_name MainScene

@export var levels: Array[PackedScene] = []

@onready var level_container: Node2D = $LevelContainer
@onready var player: Player = $Player
@onready var camera: Camera2D = $Camera2D
@onready var label: Label = $Label
@onready var pause_screen: PauseScreen = $PauseScreen
@onready var win_screen: WinScreen = $WinScreen
@onready var lose_screen: LoseScreen = $LoseScreen
var is_stopped := false
var time_elapsed := 0.0
var level_index = 0

var current_level: Level

func _ready() -> void:
	load_level(0)
	
func _process(delta):
	if !is_stopped:
		time_elapsed += delta
		$Label.text = str(time_elapsed).pad_decimals(2)

func load_level(index: int) -> void:
	if current_level:
		current_level.queue_free()

	if index >= levels.size():
		get_tree().change_scene_to_file("res://scenes/win.tscn")
		return
	var level_instance := levels[index].instantiate() as Level
	level_container.add_child(level_instance)
	current_level = level_instance

	if level_instance.player_spawn_point:
		player.global_position = level_instance.player_spawn_point.global_position
		player.deck_size = level_instance.par
		player.reset()
	if level_instance.camera_spawn_point:
		camera.global_position = level_instance.camera_spawn_point.global_position
		camera.set_original_position()
	time_elapsed = 0.0
	
func next_level():
	level_index += 1
	load_level(level_index)

func reset_level():
	player.reset()
	load_level(level_index)

func win():
	win_screen.show()
	win_screen.winSet(true)
	

func _on_next_level_button_button_up() -> void:
	win_screen.winSet(false)
	win_screen.hide()
	win_screen.updateTip()
	next_level()

func _on_pause_reset_level_signal() -> void:
	reset_level()
	pause_screen.togglePause()
	

func _on_retry_level_button_button_up() -> void:
	reset_level()
	win_screen.toggleWin()


func _on_player_died() -> void:
	lose_screen.loseSet(true)


func _on_retry_lose_level_button_button_up() -> void:
	reset_level()
	lose_screen.loseSet(false)


func _on_title_button_button_up() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
