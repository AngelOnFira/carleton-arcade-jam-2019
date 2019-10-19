extends Control

func change_volume(new_volume: int):
	var volume_text = "["
	
	for i in range(10):
		if i < new_volume:
			volume_text += " /"
		else:
			volume_text += " ."
			
	volume_text += " ]"
	$VolumeBar.text = volume_text
