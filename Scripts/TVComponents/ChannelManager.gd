extends "res://Scripts/TVComponents/TVComponents.gd"

onready var ChannelScene = preload('res://Scenes/Channel.tscn')

onready var all_possible_channels = [
	preload("res://Assets/Videos/ABC_video.webm"),
	preload("res://Assets/Videos/elephants-dream.webm")	
];
	
var channel_list = []
var channel_index = 0;

func _add_new_channel(video_index: int):
	var new_channel = ChannelScene.instance(
		video = all_possible_channels[video_index]
	)
	new_channel.hide()
	channel_list.append(new_channel)

func _intialiaze_manager(level: int):
	match level:
		1:
			_add_new_channel(1)
			channel_index = 0
		2:
			pass
		_:
			pass


func change_channel(channel_number: int):
	channel_list[channel_index].hide()
	self.channel_index = channel_number
	channel_list[channel_index].show()

# Called when the node enters the scene tree for the first time.
func _ready():
	_intialiaze_manager(1)
	channel_list[channel_index].show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
