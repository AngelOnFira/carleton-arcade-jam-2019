extends Node2D

onready var ChannelManager = preload('res://Scenes/ChannelManager.tscn')

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_channel_manager = ChannelManager.instance()
	add_child(new_channel_manager)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
