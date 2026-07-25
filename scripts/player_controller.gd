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

var prev_pos: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.RIGHT
var speed_modifier := 1.0
var has_control = true
var moving = false
var move_queue: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prev_pos = global_position
	move_queue.resize(NUM_MOVES)
	move_queue.fill(SPEED)

func _physics_process(delta):
	if !has_control:
		return
	var input_direction := Input.get_vector("move_left","move_right","move_up","move_down")
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
		rotation = direction.angle()
	else:
		moving = false

	if not moving and input_direction.length() != 0:
		#move in a forward/backward motion and play animation
		#animation_player.play("move")
		#particle_gradient = World.get_gradient_at(position)
		#speed_modifier = World.get_custom_data_at(position, "speed_modifier")
		var move_speed = SPEED * speed_modifier
		var f = move_queue.pop_front()
		if f == null: 
			f = 0
		velocity = input_direction * f
		#velocity = lerp(velocity, (input_direction.normalized() * input_direction.length()) * move_speed, SPEED * delta)
		#if !audio_player.playing:
			#audio_player.play()
	#else:
		# Bring to a stop
		#if audio_player.playing:
			#audio_player.stop()
		#velocity = Vector2.ZERO
		#animation_player.play('idle')

	#if particle_gradient and velocity:
		#left_track_particles.process_material.color_ramp = particle_gradient
		#right_track_particles.process_material.color_ramp = particle_gradient
		#left_track_particles.emitting = true
		#right_track_particles.emitting = true
	#else:
		#left_track_particles.emitting = false
		#right_track_particles.emitting = false

	# Apply movement velocity
	move_and_slide()

	# Apply Weapon Rotation
	#update_weapon_rotation(delta)
