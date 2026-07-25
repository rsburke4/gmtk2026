extends Camera2D

@onready var shakeTimer: Timer = $ShakeTimer
@onready var bumpTimer: Timer = $BumpTimer
@export var amplitude: float
@export var bumpAmp: float
var originalPosition: Vector2
var bumpDirection: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!shakeTimer.is_stopped()):
		var shakeScale = shakeTimer.time_left / shakeTimer.wait_time
		global_position = originalPosition + amplitude * Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)) * shakeScale
		print(shakeScale)
	if(!bumpTimer.is_stopped()):
		var bumpScale = abs(sin(bumpTimer.time_left / bumpTimer.wait_time))
		global_position = originalPosition + bumpDirection * bumpAmp * bumpScale
	if(bumpTimer.is_stopped() and shakeTimer.is_stopped()):
		global_position = originalPosition

func _on_player_died() -> void:
	shakeTimer.start()
	
func set_original_position():
	originalPosition = global_position
	

func _on_player_bump(direction: Vector2) -> void:
	bumpTimer.start()
	bumpDirection = direction
