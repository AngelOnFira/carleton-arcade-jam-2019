extends "res://Scripts/TVComponents/TVComponents.gd"
var color_code # Depending on the level the size will vary

var possible_colors = [
	'C',
	'Y',
	'M'
];

func create_new_color_code(level : int):
	_initialize_code(level)

func get_color_code():
	return color_code

func _ready():
	randomize()
	pass # Replace with function body.

func _init(level : int):
	pass
	
func _initialize_code(level : int):
	var code_length = 1 + 2*level
	var code_array = []
	
	for i in code_length:
		var rand = randi() % 3
		code_array.append(possible_colors[rand])
