extends "res://Scripts/TVComponents/TVComponents.gd"
var zoom_percentage : float # Range is  0.5 - 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init(starting_zoom_percentage : float):
	zoom_percentage = starting_zoom_percentage

func increase_zoom(zoom_increase_percentage : float):
	zoom_percentage += zoom_increase_percentage
	if zoom_percentage > 1.5:
		zoom_percentage = 1.5

func decrease_zoom(zoom_decrease_percentage : float):
	zoom_percentage -= zoom_decrease_percentage
	if zoom_percentage < 0.5:
		zoom_percentage = 0.5

func get_zoom_percentage():
	return zoom_percentage
