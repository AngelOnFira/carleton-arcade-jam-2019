extends "res://Scripts/TVComponents/TVComponents.gd"
var orientation : int # Range is 0 - 360

func _ready():
	pass # Replace with function body.

func rotate_right(rotate_in_degrees : int):
	orientation = (orientation + 360 + rotate_in_degrees) % 360

func rotate_left(rotate_in_degress : int):
	orientation = (orientation + 360 - rotate_in_degress) % 360

func get_rotation_in_degrees():
	return orientation

func get_rotation_in_radians():
	return (PI/180) * orientation
