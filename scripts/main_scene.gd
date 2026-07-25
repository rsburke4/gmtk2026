extends Node2D
class_name MainScene

@export var levels: Array[PackedScene] = []

@onready var level_container: Node2D = $LevelContainer
@onready var player: Player = $Player

var level_index = 0

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
	
func next_level():
	level_index += 1
	load_level(level_index)
