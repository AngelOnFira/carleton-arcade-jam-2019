extends "res://Scripts/TVComponents/TVComponents.gd"
var volume : int # Range is 0 - 10

func _ready():
	pass # Replace with function body.

func _init(starting_volume=5):
	volume = starting_volume

func load_random_target_volume():
	target_goal = randi() % 11

func increase_volume():
	if volume < 10:
		volume += 1

func decrease_volume():
	if volume > 0:
		volume -= 1

func get_volume():
	return volume
