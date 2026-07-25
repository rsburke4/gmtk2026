extends Node2D

@onready var levelInstance: Node2D
@onready var main2D : Node2D = $Main2D
@onready var titleScreen : Node2D = $Main2D/TitleParent
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	levelInstance = titleScreen

func unloadLevel():
	if(is_instance_valid(levelInstance)):
		levelInstance.queue_free()
	levelInstance = null
	
func loadLevel(levelName : String):
	unloadLevel()
	var levelPath := "res://scenes/%s.tscn" % levelName
	var levelResource := load(levelPath)
	if(levelResource):
		levelInstance = levelResource.instantiate()
		main2D.add_child(levelInstance)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_button_up() -> void:
	loadLevel("Level1")
