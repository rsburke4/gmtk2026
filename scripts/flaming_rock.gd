extends Area2D

@export var centerPt: Vector2 = Vector2.ZERO
@export var slow := 0.2
var time = 0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _physics_process(delta: float) -> void:
	time += delta
	var d = position - centerPt
	var angle = (TAU * delta * slow)
	position = d.rotated(angle) + centerPt
	sprite.rotation = position.angle()

func _on_body_entered(body: Player) -> void:
	body.lose()
