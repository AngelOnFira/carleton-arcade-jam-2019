extends Control
onready var ChannelManager = preload('res://Scenes/TVComponents/ChannelManager.tscn')

var signal_delta = 0
var component_focus = [
	false, # Channel
	false, # Volume
	false, # Saturation
	false, # Zoom
	false, # Orientation
	false, # Cyan Key
	false, # Yellow Key
	false  # Magenta Key
];

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_channel_manager = ChannelManager.instance()
	$ScreenArea.add_child(new_channel_manager)
	$ScreenArea.move_child(new_channel_manager, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	signal_delta += delta
	if delta > 3000:
		_randomize_signals()
		signal_delta = 0
	pass

func _clear_component_focus():
	for i in component_focus.size:
		component_focus[i] = false

func _randomize_signals():
	_clear_component_focus()
	var rand = randi() % 8
	component_focus[rand] = true
