extends Control

@export var backgroundSpeed: float
@export var backgroundAmp: float
@export var racoonSpeed: float
@export var racoonAmp: float

@onready var background: TextureRect = $Background
@onready var racoon: TextureRect = $Jimothy
var time
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	background.offset_transform_position = ( Vector2(sin(time * backgroundSpeed), 0) * backgroundAmp)
	#racoon.offset_transform_position = Vector2(sin(time * racoonSpeed) * racoonAmp + 101, cos(time * racoonSpeed * 0.3) * racoonAmp * 0.8)
	#racoon.pivot_offset = Vector2(sin(time * racoonSpeed) * racoonAmp + 101, cos(time * racoonSpeed * 0.3) * racoonAmp * 0.8)
	var angle = (TAU * time * racoonSpeed)
	racoon.rotation = angle #sin(time * 3 * racoonSpeed) * 10
