extends Control

onready var menu_buttons = [
	["Start", $Buttons/Start],
	["Exit", $Buttons/Exit]
]

var current_button = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw_buttons():
	for i in range(menu_buttons.size()):
		if i == current_button:
			menu_buttons[i][1].set_text("-> " + menu_buttons[i][0])
		else:
			menu_buttons[i][1].set_text("   " + menu_buttons[i][0])

func _input(event):
	if Input.is_action_just_pressed("player_one_joystick_up"):
		current_button -= 1
		if current_button == -1: current_button = menu_buttons.size() - 1
	elif Input.is_action_just_pressed("player_one_joystick_down"):
		current_button += 1
		current_button %= menu_buttons.size()
	elif Input.is_action_just_pressed("ui_accept"):
		if menu_buttons[current_button][0] == "Start":
			get_tree().change_scene("res://Scenes/Main.tscn")
		elif menu_buttons[current_button][0] == "Exit":
			get_tree().quit()
	_draw_buttons()
	
