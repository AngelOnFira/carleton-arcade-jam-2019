extends "res://Scripts/TVUI/TVUI.gd"

func change_saturation(new_saturation: int):
	var saturation_text = "["
	
	for i in range(10):
		if i < new_saturation:
			saturation_text += " >"
		else:
			saturation_text += " |"
			
	saturation_text += " ]"
	$SaturationBar.text = saturation_text
	
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
