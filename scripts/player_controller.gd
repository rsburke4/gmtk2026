extends CharacterBody2D
class_name Player

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
const SPEED = 128.0
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
var up_active = true
var down_active = true
var left_active = true
var right_active = true
var vis = false
signal died
var lost: bool
@onready var deadTimer: Timer = $DeadTimer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var deathSound: AudioStreamPlayer2D = $DeathSound
@onready var bumpSound: AudioStreamPlayer2D = $BumpSound
signal bump(direction: Vector2)
var lastDirection: Vector2
# Called when the node enters the scene tree for the first time.

class Action:
	var timer
	var rect
	var active
	func _init(t,r,a):
		timer = t
		rect = r
		active = a
@onready var upAct: Action = Action.new(
	$UpTimer,
	$"../CooldownButtons/UpRect",
	true
)
@onready var downAct: Action = Action.new(
	$DownTimer,
	$"../CooldownButtons/DownRect",
	true
)
@onready var leftAct: Action = Action.new(
	$LeftTimer,
	$"../CooldownButtons/LeftRect",
	true
)
@onready var rightAct: Action = Action.new(
	$RightTimer,
	$"../CooldownButtons/RightRect",
	true
)

var deck_size = NUM_MOVES



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()

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
		sprite.rotation = direction.angle()
	else:
		moving = false

	match(mode):
		STATE.STOPPED:
			if (up or down or left or right):
				var d = Vector2.ZERO
				if(up and upAct.active):
					upAct.active = false
					d += use_direction(Vector2(0,-1),upAct)
				if(down and downAct.active):
					downAct.active = false
					d += use_direction(Vector2(0,1),downAct)
				if(left and leftAct.active):
					leftAct.active = false
					d += use_direction(Vector2(-1,0),leftAct)
				if(right and rightAct.active):
					rightAct.active = false
					d += use_direction(Vector2(1,0),rightAct)
				if d != Vector2(0,0):
					velocity = d
				if(d.length() > 0):
					lastDirection = d.normalized()

	# Apply movement velocity
	move_and_slide()

func reset():
	lost = false
	prev_pos = global_position
	move_queue.resize(deck_size)
	move_queue.fill(SPEED)
	velocity = Vector2.ZERO

func use_direction(d,act: Action):
	var f = move_queue.pop_front()
	act.timer.start()
	if f == null: 
		f = 0
		lose()
		return Vector2.ZERO
	act.rect.activate_cooldown()
	return d * f

func lose():
	if(!lost):
		print_debug("You LOSE")
		died.emit()
		label.visible = false
		sprite.visible = false
		deadTimer.start()
		deathSound.play()
		lost = true
	#get_tree().quit()

func win():
	print_debug("You WIN")
	#Globals.loadNextLevel()
	var p = get_parent() as MainScene
	p.win()
	#p.next_level()
	#get_tree().quit()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	lose()


func _on_dead_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	bumpSound.play()
	bump.emit(lastDirection)

func _on_up_timer_timeout() -> void:
	upAct.active = true


func _on_down_timer_timeout() -> void:
	downAct.active = true


func _on_right_timer_timeout() -> void:
	rightAct.active = true


func _on_left_timer_timeout() -> void:
	leftAct.active = true
