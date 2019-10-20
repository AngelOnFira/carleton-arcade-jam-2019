extends "res://Scripts/TVUI/TVUI.gd"

func change_volume(new_volume: int):
	var volume_text = "["
	
	for i in range(10):
		if i < new_volume:
			volume_text += " |"
		else:
			volume_text += " ."
			
	volume_text += " ]"
	$VolumeBar.text = volume_text
	
	self.show()
	hide_timer.set_wait_time( 1.5 )
	hide_timer.start()
	
func _ready():
	self.hide()
	hide_timer = Timer.new()
	add_child(hide_timer)
	hide_timer.connect("timeout",self,"_on_hide_timer_timeout")
	
func _on_hide_timer_timeout():
	self.hide()
