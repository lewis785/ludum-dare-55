class_name DraggableComponent
extends Area2D

var lifted = false

func _unhandled_input(event):
	if event is InputEventMouseButton and not event.pressed:
		lifted = false
	if lifted and event is InputEventMouseMotion:
		var camera_scaler = (1 / 1.44) # Scaler to account for Camera Scaling
		var item_scaler = (1 / 0.8) # Scaler to account for Draggable Item Scaling
		position += camera_scaler * item_scaler * event.relative

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		lifted = true
