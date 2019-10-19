extends Control
onready var ChannelManager = preload('res://Scenes/TVComponents/ChannelManager.tscn')

# Logging joystick input
var past_joystick_input : int
var current_joystick_input : int

# Keeps track what buttons have been pressed
var component_focus = [ # Only one can be in focus at a time (maybe turn this into an integer later)
	false, # Channel
	false, # Volume
	false, # Saturation
	false, # Zoom
	false, # Orientation
	false, # Cyan Key
	false, # Yellow Key
	false  # Magenta Key
];

# Debuggin tool
var signal_delta = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_channel_manager = ChannelManager.instance()
	$ScreenArea.add_child(new_channel_manager)
	$ScreenArea.move_child(new_channel_manager, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	signal_delta += delta
	if signal_delta > 3000:
		_randomize_signals()
		signal_delta = 0
	_process_input()
	pass

func _clear_component_focus():
	for i in component_focus.size():
		component_focus[i] = false

func _randomize_signals():
	_clear_component_focus()
	var rand = randi() % 8
	component_focus[rand] = true

func _process_button_pressed():
	for i in component_focus.size():
		if Input.is_action_just_pressed("player_one_button_" + (i+1)):
			component_focus[i] = true
		elif Input.is_action_just_released("player_one_button_" + (i+1)):
			component_focus[i] = false
	pass

func _process_joystick_pressed():
	pass

func _process_input():
	var focus = -1;
	for i in component_focus.size():
		if component_focus[i]:
			if focus > -1: # If multiple keys are pressed
				focus = -1
				break
			focus = i
	
	
	
	match focus :
		-1: # No need to process input
			pass
		1: # ChannelManager
			pass
		2: # Volume
			pass
		3: # Saturation
			pass
		4: # Zoom
			pass
		5: # Orientation
			pass
		6: # Cyan
			pass
		7: # Yellow
			pass
		8: # Magenta
			pass
