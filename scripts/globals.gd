extends Node

var musicVolume: float = 1.0
var sfxVolume: float = 1.0
var currentLevel: int = 0

var levels = [
	"res://scenes/Level1.tscn",
	"res://scenes/Level2.tscn",
	"res://scenes/Level3.tscn"
]

func loadLevel(index: int):
	if(index < levels.size()):
		get_tree().change_scene_to_file(levels[index])
		
func loadNextLevel():
	if(currentLevel + 1 < levels.size()):
		currentLevel = currentLevel + 1
		get_tree().change_scene_to_file(levels[currentLevel])
