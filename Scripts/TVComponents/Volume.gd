extends "res://Scripts/TVComponents/TVComponents.gd"
var volume : int # Range is 0 - 10 (done with volume going 0 - 1000)

func _ready():
	pass # Replace with function body.

func _init(starting_volume=5):
	volume = starting_volume * 100

func load_random_target():
	target_goal = randi() % 11

func increase_volume():
	if volume < 1000:
		volume += 5

func decrease_volume():
	if volume > 0:
		volume -= 5

func get_volume():
	return volume / 100

func check_goal():
	return (volume / 100) == target_goal
