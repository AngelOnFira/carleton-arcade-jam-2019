extends "res://Scripts/TVComponents/TVComponents.gd"

onready var ChannelScene = preload('res://Scenes/TVComponents/Channel.tscn')

var all_possible_channels = [];
	
var channel_list = []
var channel_index = 0;

func _add_new_channel(video_index: int):
	var new_channel = ChannelScene.instance()
	new_channel.set_video_stream(all_possible_channels[video_index])
	new_channel.hide()
	add_child(new_channel)
	channel_list.append(new_channel)

func _intialiaze_manager(level: int):
	load_level(level)

func load_level(level : int):
	match level:
		1:
			_add_new_channel(0)
			_add_new_channel(1)
			_add_new_channel(2)
			_add_new_channel(3)
			_add_new_channel(4)
			channel_index = 0
			target_goal = randi() % 5
		2:
			pass
		_:
			pass

func change_channel(channel_number: int):
	if channel_number >= channel_list.size():
		pass
	channel_list[channel_index].hide()
	channel_index = channel_number
	channel_list[channel_index].show()

# Called when the node enters the scene tree for the first time.
func _ready():

	_load_videos("res://Assets/Videos")

	_intialiaze_manager(1)
	channel_list[channel_index].show()

func _load_videos(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if file_name.find(".ogv") >= 0:
				var new_video = load(path + "/" + file_name)
				all_possible_channels.append(new_video)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func check_goal():
	return target_goal == channel_index
