extends Node2D

onready var camera = $Camera2D

func _process(delta):
	camera.setposition()
