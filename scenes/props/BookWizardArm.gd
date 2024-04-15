extends Node2D


var enabled = false
var offset = Vector2(0,250)
var anim_sprite : AnimatedSprite2D

func _ready():
	anim_sprite = find_child("AnimatedSprite2D")

func _input(event):
	if enabled:
		if event is InputEventMouseMotion:
			var camera_scaler = (1 / 1.44) # Scaler to account for Camera Scaling
			set_position((event.position * camera_scaler) + offset)
		if event is InputEventMouseButton:
			if event.pressed:
				anim_sprite.animation = "Grab"
			else:
				anim_sprite.animation = "default"
