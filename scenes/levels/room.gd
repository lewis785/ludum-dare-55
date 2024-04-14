extends TextureRect

class_name Room

@export var max_brightness: int = 6
@export var flicker : float = 0.2
@export var flicker_delay: int = 4
var flicker_ticker : int = 0

var is_setup : bool = false
var torches =  []

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in range(3):
		var torch = find_child("Torch" + str(i))
		torches.append(torch)
		torch.find_child("TorchAnimation").animation = "notLitFam"
		torch.find_child("PointLight2D").energy = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_setup:
		flicker_ticker += 1
		if flicker_ticker % flicker_delay == 0:
			for torch in torches:
				var randTmp = rng.randf_range(-flicker, flicker)
				torch.find_child("PointLight2D").energy = max_brightness + randTmp
			

func setup_room(lives=3):
	_set_torches_brightness(max_brightness,lives)
	is_setup = true
	flicker_ticker = 0

func _set_torches_brightness(brightness : int, amount : int = 0):
		if brightness == 0:
			for torch in torches:
				torch.find_child("TorchAnimation").animation = "notLitFam"
				torch.find_child("PointLight2D").energy = 0.0
				torch.find_child("Extinguish").play()
			is_setup = false
		else:
			var rng = RandomNumberGenerator.new()
			var randTmp
			var torch
			# Torches are called in odd order due to room order
			if(amount >= 2):
				torch = torches[0]
				torch.find_child("TorchAnimation").animation = "litfam"
				randTmp = rng.randf_range(-flicker, flicker)
				torch.find_child("PointLight2D").energy = brightness + randTmp
				torch.find_child("Ignite").play()
			if(amount >= 1):
				torch = torches[1]
				torch.find_child("TorchAnimation").animation = "litfam"
				randTmp = rng.randf_range(-flicker, flicker)
				torch.find_child("PointLight2D").energy = brightness + randTmp
				torch.find_child("Ignite").play()
			if(amount >= 3):
				torch = torches[2]
				torch.find_child("TorchAnimation").animation = "litfam"
				randTmp = rng.randf_range(-flicker, flicker)
				torch.find_child("PointLight2D").energy = brightness + randTmp
				torch.find_child("Ignite").play()
