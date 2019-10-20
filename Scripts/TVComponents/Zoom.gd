extends "res://Scripts/TVComponents/TVComponents.gd"
var zoom_percentage : float # Range is  0.5 - 1.5
var zoom_direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init(starting_zoom_percentage=1.0):
	zoom_percentage = starting_zoom_percentage

func load_new_target_zoom():
	target_goal = randf() + 0.5

func change_zoom():
	zoom_percentage += 0.015 * zoom_direction
	if zoom_percentage > 1.5:
		zoom_direction = -1
		zoom_percentage = 1.5
	elif zoom_percentage < 0.5:
		zoom_direction = 1
		zoom_percentage = 0.5

func get_zoom():
	return zoom_percentage
	
func check_goal():
	return abs(zoom_percentage - target_goal) < 0.1
