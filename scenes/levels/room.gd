extends TextureRect

class_name Room

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _setTorchesBrightness(brightness : int, amount : int = 0):
		if brightness == 0:
			for i in range(3):
				var torch = find_child("Torch" + str(i))
				torch.find_child("TorchAnimation").animation = "notLitFam"
				torch.find_child("PointLight2D").energy = 0.0
				torch.find_child("Extinguish").play()
		else:
			var torch
			# Torches are called in odd order due to room order
			if(amount >= 2):
				torch = find_child("Torch0")
				torch.find_child("TorchAnimation").animation = "litfam"
				torch.find_child("PointLight2D").energy = brightness
			if(amount >= 1):
				torch = find_child("Torch1")
				torch.find_child("TorchAnimation").animation = "litfam"
				torch.find_child("PointLight2D").energy = brightness
			if(amount >= 3):
				torch = find_child("Torch2")
				torch.find_child("TorchAnimation").animation = "litfam"
				torch.find_child("PointLight2D").energy = brightness
