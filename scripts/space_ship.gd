extends Area2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
var level_win: bool
@export var launchForce : float
@export var shakeAmplitude : float
@onready var winTimer : Timer = $WinTimer
@onready var rocketSound : AudioStreamPlayer2D = $RocketAudio

func _process(delta: float) -> void:
	if(level_win and !winTimer.is_stopped()):
		launchForce += launchForce * delta
		move_local_y(-launchForce)
		move_local_x(randf_range(-1.0, 1.0) * shakeAmplitude)
		

func _on_body_entered(body: Player) -> void:
	audio_stream_player_2d.play()
	body.win()
	level_win = true
	rocketSound.play()
	winTimer.start()
	
