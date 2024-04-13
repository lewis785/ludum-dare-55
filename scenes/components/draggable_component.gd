class_name DraggableComponent
extends Area2D

var lifted = false

func _unhandled_input(event):
	if event is InputEventMouseButton and not event.pressed:
		lifted = false
	if lifted and event is InputEventMouseMotion:
		position += event.relative

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		lifted = true
