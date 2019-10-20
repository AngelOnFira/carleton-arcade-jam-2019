extends Control

var timer_amount: float = 120.00

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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(8):
		left_player_buttons[i].set_pressed($Window/PlayerZone/TVView/TV.component_focus[i][0])
	_update_timer(delta)
	if timer_amount <= 0.0:
		pass
		#game over


func _update_timer(delta):
	timer_amount -= delta
	var mins_left = str(int(timer_amount / 60))
	var seconds_left = str(int(timer_amount) % 60)
	$Window/PlayerZone/TVView/Control/TimeLeft.set_text(mins_left + ":" + seconds_left)
