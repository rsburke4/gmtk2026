extends CharacterBody2D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
const SPEED = 64.0
const TURN_SPEED = 0.1
const ROTATE_SPEED = 20
const NUM_MOVES = 10
@onready var label: Label = $Label
enum STATE{MOVING,STOPPED}
var prev_pos: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.RIGHT
var speed_modifier := 1.0
var has_control = true
var moving = false
var move_queue: Array = []
var mode: STATE = STATE.STOPPED
var draw_from_deck = true
@onready var move_timer: Timer = $MoveTimer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prev_pos = global_position
	move_queue.resize(NUM_MOVES)
	move_queue.fill(SPEED)

func _physics_process(delta):
	if !has_control:
		return

	var up := Input.is_action_just_pressed("move_up")
	var down := Input.is_action_just_pressed("move_down")
	var left := Input.is_action_just_pressed("move_left")
	var right := Input.is_action_just_pressed("move_right")
	label.text = str(move_queue.size())
	#var drive_input := Input.get_axis("move_up","move_down")
	#var turn_input	:= Input.get_axis("move_left","move_right")

	var cur_pos: Vector2 = global_position
	var mov_delta = cur_pos - prev_pos
	prev_pos = cur_pos
	if mov_delta.length()/delta > SPEED - 1:
		moving = true
		# Rotate direction based on input vector and apply turn speed
		direction = direction.rotated(velocity.length() * (PI/2) * TURN_SPEED * delta)
		animated_sprite_2d.rotation = direction.angle()
	else:
		moving = false

	match(mode):
		STATE.STOPPED:
			if (up or down or left or right):
				if(draw_from_deck):
					draw_from_deck = false
					var f = move_queue.pop_front()
					move_timer.start()
					if f == null: 
						f = 0
					var d = Vector2.ZERO
					if(up):
						d += Vector2(0,-1)
					if(down):
						d += Vector2(0,1)
					if(left):
						d += Vector2(-1,0)
					if(right):
						d += Vector2(1,0)
					apply_force(d.normalized(),f)

	# Apply movement velocity
	move_and_slide()

func apply_force(dir: Vector2, force: float):
	velocity = dir * force


func _on_move_timer_timeout() -> void:
	draw_from_deck = true
