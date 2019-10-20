extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout",self,"_on_timer_timeout")
	timer.set_wait_time( 2 )
	timer.start()

func _on_timer_timeout():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
