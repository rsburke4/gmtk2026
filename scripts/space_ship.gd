extends Area2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body: Player) -> void:
	audio_stream_player_2d.play()
	body.win()
