extends Control
onready var ChannelManager = preload('res://Scenes/TVComponents/ChannelManager.tscn')
onready var VolumeComponent = preload("res://Scenes/TVComponents/Volume.tscn")
onready var SaturationComponent = preload("res://Scenes/TVComponents/Saturation.tscn")
onready var ZoomComponent = preload("res://Scenes/TVComponents/Zoom.tscn")
onready var OrientationComponent = preload("res://Scenes/TVComponents/Orientation.tscn")
onready var ColorCodeManager = preload("res://Scenes/TVComponents/ColorCodeManager.tscn")

# Logging joystick input
var previous_joystick_input : int
var current_joystick_input : int
var corner_joystick_logging : int
var next_level = false

# Keeps track what buttons have been pressed [focus, avaliable, clear]
var component_focus = [ # Only one can be in focus at a time (maybe turn this into an integer later)
	[false, false, false], # Channel
	[false, false, false], # Volume
	[false, false, false], # Saturation
	[false, false, false], # Zoom
	[false, false, false], # Orientation
	[false, false, false], # Cyan Key
	[false, false, false], # Yellow Key
	[false, false, false]  # Magenta Key
];


# Debuggin tool
var input_delta = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	# Channel Manager
	var new_channel_manager = ChannelManager.instance()
	$ScreenArea.add_child(new_channel_manager)
	$ScreenArea.move_child(new_channel_manager, 0)
	
	# Volume Controller
	var new_volume_controller = VolumeComponent.instance()
	$VolumeControl.add_child(new_volume_controller)
	
	# Saturation Controller
	var new_saturation_controller = SaturationComponent.instance()
	$SaturationControl.add_child(new_saturation_controller)
	
	var new_zoom_controller = ZoomComponent.instance()
	
	_set_up_game_level(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	input_delta += delta
	if input_delta > 1.0 / 60:
		_process_input()
		_process_for_goal()
		next_level = _check_for_goal()
		input_delta = 0

func _clear_component_focus():
	for i in component_focus.size():
		component_focus[i][0] = false

func _process_button_pressed():
	for i in component_focus.size():
		if Input.is_action_pressed("player_one_button_" + str(i+1)):
			component_focus[i][0] = true
		else:
			component_focus[i][0] = false

func _process_joystick_pressed():	
	if Input.is_action_just_pressed("player_one_joystick_up") or Input.is_action_pressed("player_one_joystick_up"):
		if Input.is_action_pressed("player_one_joystick_left"):
			current_joystick_input = 1
		elif Input.is_action_pressed("player_one_joystick_right"):
			current_joystick_input = 7
		else:
			current_joystick_input = 0
	elif Input.is_action_just_pressed("player_one_joystick_left") or Input.is_action_pressed("player_one_joystick_left"):
		if Input.is_action_pressed("player_one_joystick_up"):
			current_joystick_input = 1
		elif Input.is_action_pressed("player_one_joystick_down"):
			current_joystick_input = 3
		else:
			current_joystick_input = 2
	elif Input.is_action_just_pressed("player_one_joystick_down") or Input.is_action_pressed("player_one_joystick_down"):
		if Input.is_action_pressed("player_one_joystick_left"):
			current_joystick_input = 3
		elif Input.is_action_pressed("player_one_joystick_right"):
			current_joystick_input = 5
		else:
			current_joystick_input = 4
	elif Input.is_action_just_pressed("player_one_joystick_right") or Input.is_action_pressed("player_one_joystick_right"):
		if Input.is_action_pressed("player_one_joystick_down"):
			current_joystick_input = 5
		elif Input.is_action_pressed("player_one_joystick_up"):
			current_joystick_input = 7
		else:
			current_joystick_input = 6
	else:
		current_joystick_input = -1
		
	if current_joystick_input != previous_joystick_input:
		corner_joystick_logging += 1
	
	if corner_joystick_logging > 2:
		previous_joystick_input = current_joystick_input
		corner_joystick_logging = 0
	else:
		current_joystick_input = previous_joystick_input

func _set_up_game_level(level : int):
	match level:
		1:
			$ScreenArea/Channels.load_level(1)
			$VolumeControl/VolumeController.load_random_target_volume()
			component_focus[0][1] = true
			component_focus[1][1] = true
		2:
			$ScreenArea/Channels.load_level(1)
			$VolumeControl/VolumeController.load_random_target_volume()
			$SaturationControl/SaturationController.load_random_target_saturation()
			component_focus[0][1] = true
			component_focus[1][1] = true
			component_focus[2][1] = true
		3: 
			$ScreenArea/Channels.load_level(1)
			$VolumeControl/VolumeController.load_random_target_volume()
			$SaturationControl/SaturationController.load_random_target_saturation()
			$ZoomControl/ZoomController.load_new_target_zoom()
			component_focus[0][1] = true
			component_focus[1][1] = true
			component_focus[2][1] = true
			component_focus[3][1] = true
		_:
			pass

func _check_for_goal():
	var level_complete = true
	for i in component_focus.size():
		if component_focus[i][1]:
			level_complete = level_complete and component_focus[i][2]
	return level_complete

func _process_for_goal():
	for i in component_focus.size():
		if component_focus[i][1]:
			component_focus[i][2] = _check_goal_for_component(i)

func _check_goal_for_component(component: int):
	match component:
		0:
			return $ScreenArea/Channels.check_goal()
		1:
			return $VolumeControl/VolumeController.check_goal()
		_:
			return false

func _process_input():
	# Process RAW User input
	_process_button_pressed()
	_process_joystick_pressed()

	# Check to see what TV Component should be focused
	var focus = -1;
	for i in component_focus.size():
		if component_focus[i][0] and component_focus[i][1]:
			if focus > -1: # If multiple keys are pressed
				focus = -1
				break
			focus = i
	
	# print("FOCUS: " + str(focus))
	# Update Components based on what is in focus
	match focus :
		-1: # No need to process input
			pass
		0: # ChannelManager
			if not (current_joystick_input < 0 or current_joystick_input > 7):
				$ScreenArea/Channels.change_channel(current_joystick_input)
		1: # Volume
			if current_joystick_input == 2:
				$VolumeControl/VolumeController.decrease_volume()
			elif current_joystick_input == 6:
				$VolumeControl/VolumeController.increase_volume()
			get_parent().get_node("TVUI/Volume").change_volume($VolumeControl/VolumeController.get_volume())
		2: # Saturation
			if current_joystick_input == 0:
				$SaturationControl/SaturationController.increase_saturation()
			elif current_joystick_input == 4:
				$SaturationControl/SaturationController.decrease_saturation()
			pass
		3: # Zoom
			pass
		4: # Orientation
			pass
		5: # Cyan
			pass
		6: # Yellow
			pass
		7: # Magenta
			pass
		_: # In case of Error
			pass
