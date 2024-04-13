class_name DraggableComponent
extends Area2D

var lifted = false

func _unhandled_input(event):
	if event is InputEventMouseButton and not event.pressed:
		lifted = false
	if lifted and event is InputEventMouseMotion:
		position += event.relative

func _input_event(viewport, event, shape_idx):
	print(event)
	if event is InputEventMouseButton and event.pressed:
		print("Click")
		lifted = true

