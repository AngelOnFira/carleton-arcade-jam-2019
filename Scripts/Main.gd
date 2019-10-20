extends Control

var timer_amount: float = 10.00
var current_level: int = 1
var remaining_commands: int = 2

onready var left_player_buttons = [
	$Window/PlayerZone/Player1/ButtonsLeftRowsTop/ButtonsLeftCols/Button1,
	$Window/PlayerZone/Player1/ButtonsLeftRowsTop/ButtonsLeftCols/Button2,
	$Window/PlayerZone/Player1/ButtonsLeftRowsTop/ButtonsLeftCols/Button3,
	$Window/PlayerZone/Player1/ButtonsLeftRowsTop/ButtonsLeftCols/Button4,
	$Window/PlayerZone/Player1/ButtonsLeftRowsTop/ButtonsLeftCols2/Button1,
	$Window/PlayerZone/Player1/ButtonsLeftRowsTop/ButtonsLeftCols2/Button2,
	$Window/PlayerZone/Player1/ButtonsLeftRowsTop/ButtonsLeftCols2/Button3,
	$Window/PlayerZone/Player1/ButtonsLeftRowsTop/ButtonsLeftCols2/Button4,
]

onready var right_player_buttons = [
	$Window/PlayerZone/Player2/ButtonsRightRowsTop/ButtonsRightCols/Button1,
	$Window/PlayerZone/Player2/ButtonsRightRowsTop/ButtonsRightCols/Button2,
	$Window/PlayerZone/Player2/ButtonsRightRowsTop/ButtonsRightCols/Button3,
	$Window/PlayerZone/Player2/ButtonsRightRowsTop/ButtonsRightCols/Button4,
	$Window/PlayerZone/Player2/ButtonsRightRowsTop/ButtonsRightCols2/Button1,
	$Window/PlayerZone/Player2/ButtonsRightRowsTop/ButtonsRightCols2/Button2,
	$Window/PlayerZone/Player2/ButtonsRightRowsTop/ButtonsRightCols2/Button3,
	$Window/PlayerZone/Player2/ButtonsRightRowsTop/ButtonsRightCols2/Button4,
]

var button_words = [
	"CHNL",
	"VOL",
	"SAT",
	"ZOOM",
	"ORI",
	"CYN",
	"MGA",
	"YLW"
]

onready var command_options = [
	# Level 1
	["Set volume to ", $Window/PlayerZone/TVView/TV/VolumeControl/VolumeController],
	["Change the channel to ", $Window/PlayerZone/TVView/TV/ScreenArea/Channels],
	# Level 2
	["Change the saturation to ", $Window/PlayerZone/TVView/TV/VolumeControl/VolumeController],
]

var levels = [2, 3]

var commands = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	randomize()
	commands.append(_spawn_command())
	print(commands)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(8):
		if $Window/PlayerZone/TVView/TV.component_focus[i][1]:
			left_player_buttons[i].set_pressed($Window/PlayerZone/TVView/TV.component_focus[i][0])
			left_player_buttons[i].set_text(button_words[i])
		else:
			left_player_buttons[i].set_text("")

	_update_timer(delta)
	if timer_amount <= 0.0:
		get_tree().change_scene("res://Scenes/GameOver.tscn")

	if commands[0][1].check_goal():
		commands[0] = _spawn_command()
		remaining_commands -= 1
		if current_level < 5:
			timer_amount += 1/5.5 * pow(current_level - 6, 2) + 0.5
		else:
			timer_amount += 0.5

		if remaining_commands <= 0:
			current_level += 1
			remaining_commands = current_level * 5
			$Window/PlayerZone/TVView/TV.set_up_game_level(current_level)
			print("Level " + str(current_level))


func _update_timer(delta):
	timer_amount -= delta
	var mins_left = str(int(timer_amount / 60))
	var seconds_left = str(int(timer_amount) % 60)
	$Window/PlayerZone/TVView/Control/TimeLeft.set_text(mins_left + ":" + seconds_left)

func _spawn_command():
	var random_command = (randi() % (levels[current_level - 1]))
	command_options[random_command][1].load_random_target()
	var target_value = command_options[random_command][1].target_goal
	$Window/BottomInfo/Command.set_text(str(command_options[random_command][0]) + str(target_value))
	
	return [
		str(command_options[random_command][0]) + str(target_value),
		command_options[random_command][1]
	]
