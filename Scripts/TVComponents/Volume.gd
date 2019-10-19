extends "res://Scripts/TVComponents/TVComponents.gd"
var volume : int # Range is 0 - 10

func _ready():
	pass # Replace with function body.

func _init(starting_volume : int):
	volume = starting_volume

func increase_volume():
	if volume < 10:
		volume += 1

func decrease_volume():
	if volume > 0:
		volume -= 1

func get_volume():
	return volume
