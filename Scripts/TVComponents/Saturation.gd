extends "res://Scripts/TVComponents/TVComponents.gd"
var saturation : int # Range is 0 - 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init(starting_saturation : int):
	saturation = starting_saturation

func increase_saturation():
	if saturation < 10:
		saturation += 1;

func decrease_saturation():
	if saturation > 0:
		saturation -= 1;

func get_saturation():
	return saturation
