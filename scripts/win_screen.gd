extends CanvasLayer
class_name WinScreen
@onready var time: Label = $Control/VBoxContainer/Time
@onready var rich_text_label: RichTextLabel = $Control/VBoxContainer/RichTextLabel

var child
var tipList: Array[String] = [
	"",
	"Tip: Don't touch the fiery space rocks!",
	"Tip: You don't need to wait until Jimothy reaches a rock to throw more trash.",
	"Tip: If Jimothy flies off the screen, he will be lost in space!",
	"Tip: Hazards can move at different speeds. Don't forget to watch the timing of both cooldowns and hazards!",
	"Tip: There are multiple solutions to each level. See how quickly you can get to the ship!"
]
var tipIdx = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var paused = get_tree().paused
	visible = paused
	child = get_child(0)
	child.process_mode = Node.PROCESS_MODE_DISABLED
	winSet(false)

func updateTip():
	tipIdx += 1

func resetTip():
	tipIdx = 0
	
func toggleWin():
	var paused = !get_tree().paused
	get_tree().paused = paused
	visible = paused
	if(!paused):
		child.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		child.process_mode = Node.PROCESS_MODE_ALWAYS
	
func winSet(paused: bool):
	get_tree().paused = paused
	visible = paused
	if(tipIdx < tipList.size()):
		rich_text_label.text = tipList[tipIdx]
	if(!paused):
		child.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		child.process_mode = Node.PROCESS_MODE_ALWAYS
	var p = get_parent() as MainScene
	var time_elapsed = p.time_elapsed
	time.text = "in " + str(time_elapsed).pad_decimals(2) +"s"
