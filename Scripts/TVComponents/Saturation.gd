extends "res://Scripts/TVComponents/TVComponents.gd"
var saturation : int # Range is 0 - 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init(starting_saturation=5):
	saturation = starting_saturation * 100

func load_random_target():
	target_goal = randi() % 11

func increase_saturation():
	if saturation < 1000:
		saturation += 5;

func decrease_saturation():
	if saturation > 0:
		saturation -= 5;

func get_saturation():
	return saturation / 100
	
func check_goal():
	return (saturation / 100) == target_goal
