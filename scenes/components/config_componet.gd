extends Node2D

class_name ConfigComponent

var save_path = "res://save-file.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_path)

func save_value(section, key, value):
	config.set_value(section, key, value)
	config.save(save_path)

func load_value(section, key, default=null):
	return config.get_value(section, key, default)
