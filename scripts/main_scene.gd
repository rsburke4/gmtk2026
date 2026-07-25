extends Node2D

@export var levels: Array[PackedScene] = []

@onready var level_container: Node2D = $LevelContainer
@onready var player: Player = $Player
@onready var camera: Camera2D = $Camera2D

var current_level: Level

func _ready() -> void:
	load_level(0)

func load_level(index: int) -> void:
	if current_level:
		current_level.queue_free()

	var level_instance := levels[index].instantiate() as Level
	level_container.add_child(level_instance)
	current_level = level_instance

	if level_instance.player_spawn_point:
		player.global_position = level_instance.player_spawn_point.global_position
		camera.global_position = level_instance.camera_spawn_point.global_position
		camera.set_original_position()
	
