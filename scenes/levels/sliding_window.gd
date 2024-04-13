extends Node2D

@onready var camera = $Camera2D
@onready var torch_animation = $TorchAnimation

@export var cameraSpeed: int
@export var lives: int

var roomScene = load("res://scenes/levels/room.tscn")
var torchScene = load("res://scenes/props/torch.tscn")

var target = 0
var target_coordinates = Vector2(400,225)	#Initialise the variable so it doesnt complain
var camera_coordinates = Vector2(400,225)
#: Array[PackedScene] = []

#Camera set to 1.44
func _ready():
	_createNextRoom(0)
		
func _input(_event):
	if(Input.is_key_pressed(KEY_ENTER)):	#UPDATE WHEN BATTLE ENDS
			_createNextRoom(target+1)
			target+=1
			target_coordinates = Vector2(400+(800*target), 225)


func _process(delta):
	camera_coordinates = camera.get_position()
	camera.position = camera_coordinates.lerp(target_coordinates, cameraSpeed*delta)
	camera.set_position(camera.position)

func _createNextRoom(nextRoom):
		var roomInstance = roomScene.instantiate()
		roomInstance.position = Vector2((800*nextRoom), 0)
		add_child(roomInstance)
		
		for x in range(3):
			#print("creating torch")
			var torchInstance: Node2D = torchScene.instantiate()
			add_child(torchInstance)
			
			if(x == 0):
				torchInstance.position = Vector2(110+(800*nextRoom), 175)
				torchInstance.set_rotation_degrees(-15)
				if(lives < 2):
					torchInstance.find_child("TorchAnimation").animation = "notLitFam"
			if(x == 1):
				torchInstance.position = Vector2(400+(800*nextRoom), 100)
				if(lives < 1):
					torchInstance.find_child("TorchAnimation").animation = "notLitFam"
			if(x == 2):
				if(lives < 3):
					torchInstance.find_child("TorchAnimation").animation = "notLitFam"
				torchInstance.position = Vector2(675+(800*nextRoom), 175)
				torchInstance.set_rotation_degrees(15)
	
