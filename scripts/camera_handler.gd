extends Camera2D

@onready var shakeTimer: Timer = $ShakeTimer
@export var amplitude: float
var originalPosition: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!shakeTimer.is_stopped()):
		var shakeScale = shakeTimer.time_left / shakeTimer.wait_time
		global_position = originalPosition + amplitude * Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)) * shakeScale
		print(shakeScale)

func _on_player_died() -> void:
	print("Cam died")
	shakeTimer.start()
	
func set_original_position():
	originalPosition = global_position
	
