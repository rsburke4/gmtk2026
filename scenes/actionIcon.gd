extends ColorRect
class_name ActionIcon

var cooldown_active := false
var cooldown_percent := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	material.set_shader_parameter("cooldown_progress",cooldown_percent)
	pass

func activate_cooldown(duration):
	if cooldown_active: return
	print("Activated cooldown")
	cooldown_active = true
	cooldown_percent = 0
	var tween := create_tween()
	tween.tween_property(self, "cooldown_percent", 100, duration).from(0)
	tween.finished.connect(on_cooldown_finished)
	
func on_cooldown_finished():
	cooldown_active = false
	print("Ability ready")
