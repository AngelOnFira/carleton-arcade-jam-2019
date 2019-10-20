extends "res://Scripts/TVComponents/TVComponents.gd"
var orientation : int # Range is 0 - 360

func _ready():
	pass # Replace with function body.

func _init(starting_rotation=0):
	orientation = starting_rotation

func load_new_target_orientation():
	target_goal = randi() % 361

func rotate_right():
	orientation = (orientation + 360 + 5) % 360

func rotate_left():
	orientation = (orientation + 360 - 5) % 360

func check_goal():
	return abs(target_goal - orientation) <= 10

func get_rotation_in_degrees():
	return orientation

func get_rotation_in_radians():
	return (PI/180) * orientation
