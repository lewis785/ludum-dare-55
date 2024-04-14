extends Node2D

class_name Torch

@export var brightness: int = 0:
	set(value):
		brightness = value
		if is_node_ready():
			update_torch()
@export var flicker: float = 0.2
@export var flicker_delay: int = 0.4

@onready var torch_animation = $TorchAnimation
@onready var point_light_2d = $PointLight2D
@onready var ignite = $Ignite
@onready var extinguish = $Extinguish

var lit: bool;
var timer = 0.0

func _ready():
	lit = brightness > 0;
	update_torch();

func _process(delta):
	if !lit:
		return
	
	if timer < flicker_delay:
		timer += delta
		return
	
	_flicker()
	timer = 0.0

func _flicker():
	var randTmp = randf_range(-flicker, flicker)
	point_light_2d.energy = brightness + randTmp
	
func update_torch():		
	_flicker()
	
	if brightness == 0:
		if lit:
			extinguish.play()	
		lit = false
		point_light_2d.energy = 0.0
		torch_animation.animation = "notLitFam"
	
	if brightness > 0:
		if !lit:
			ignite.play()
		lit = true
		torch_animation.animation = "litfam"
