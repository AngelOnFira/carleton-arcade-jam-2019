extends Control

func set_video_stream(video_stream: VideoStreamTheora):
	$VideoPlayer.stream = video_stream
	$VideoPlayer.connect("finished", self, "_on_VideoPlayer_finished")
	

func _ready():
	pass # Replace with function body.

func _on_VideoPlayer_finished():
	$VideoPlayer.play()
