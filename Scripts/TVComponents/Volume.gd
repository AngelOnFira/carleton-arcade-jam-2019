extends "res://Scripts/TVComponents/TVComponents.gd"
var volume : int

func _ready():
	pass # Replace with function body.

func _init(starting_volume : int):
	volume = starting_volume

func increase_volume():
	volume += 1

func decrease_volume():
	volume -= 1

func get_volume():
	return volume