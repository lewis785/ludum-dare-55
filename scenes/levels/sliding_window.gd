extends Node2D

@onready var camera = $Camera2D
@export var cameraSpeed: int
@export var lives: int

var roomScene = preload("res://scenes/levels/room.tscn")

var roomInstance1 = roomScene.instantiate()
var roomInstance2 = roomScene.instantiate()

var target_coordinates = Vector2(400,225)	#Initialise the variable so it doesnt complain
var camera_coordinates = Vector2(400,225)

var target = 0
var roomsMade = -1	#Has to be negative for initial room to be instantiated.

#Camera set to 1.44
func _ready():
	_createNextRoom(0)
		
func _input(_event):
	if(Input.is_key_pressed(KEY_ENTER)):	#UPDATE WHEN BATTLE ENDS
			target+=1

func _process(delta):
	camera_coordinates = camera.get_position()
	camera.position = camera_coordinates.move_toward(target_coordinates, cameraSpeed*delta)
	camera.set_position(camera.position)
	_createNextRoom(target)
	
func _createNextRoom(nextRoom):
	if(nextRoom %2 == 0):
		_createNextRoomEven(nextRoom)
	else:
		_createNextRoomOdd(nextRoom)
		
func _createNextRoomOdd(nextRoom):
	roomInstance1.find_child("Torch0").find_child("TorchAnimation").animation = "notLitFam"
	roomInstance1.find_child("Torch0").find_child("PointLight2D").energy = 0.0
	roomInstance1.find_child("Torch1").find_child("TorchAnimation").animation = "notLitFam"
	roomInstance1.find_child("Torch1").find_child("PointLight2D").energy = 0.0
	roomInstance1.find_child("Torch2").find_child("TorchAnimation").animation = "notLitFam"
	roomInstance1.find_child("Torch2").find_child("PointLight2D").energy = 0.0
	if(nextRoom > roomsMade):
		
		roomInstance1.position = Vector2((800*nextRoom), 0)
		add_child(roomInstance1)
		roomsMade += 1
		if(nextRoom == roomsMade):
			target_coordinates = Vector2(400+(800*target), 225)
	if(target_coordinates == camera_coordinates):
		if(lives >= 2):
			roomInstance1.find_child("Torch0").find_child("TorchAnimation").animation = "litfam"
			roomInstance1.find_child("Torch0").find_child("PointLight2D").energy = 12.0
		if(lives >= 1):
			roomInstance1.find_child("Torch1").find_child("TorchAnimation").animation = "litfam"
			roomInstance1.find_child("Torch1").find_child("PointLight2D").energy = 12.0
		if(lives >= 3):
			roomInstance1.find_child("Torch2").find_child("TorchAnimation").animation = "litfam"
			roomInstance1.find_child("Torch2").find_child("PointLight2D").energy = 12.0

func _createNextRoomEven(nextRoom):
	roomInstance2.find_child("Torch0").find_child("TorchAnimation").animation = "notLitFam"
	roomInstance2.find_child("Torch0").find_child("PointLight2D").energy = 0.0
	roomInstance2.find_child("Torch1").find_child("TorchAnimation").animation = "notLitFam"
	roomInstance2.find_child("Torch1").find_child("PointLight2D").energy = 0.0
	roomInstance2.find_child("Torch2").find_child("TorchAnimation").animation = "notLitFam"
	roomInstance2.find_child("Torch2").find_child("PointLight2D").energy = 0.0
	if(nextRoom > roomsMade):
		
		roomInstance2.position = Vector2((800*nextRoom), 0)
		add_child(roomInstance2)
		roomsMade += 1
		if(nextRoom == roomsMade):
			target_coordinates = Vector2(400+(800*target), 225)
			
	if(target_coordinates == camera_coordinates):
		if(lives >= 2):
			roomInstance2.find_child("Torch0").find_child("TorchAnimation").animation = "litfam"
			roomInstance2.find_child("Torch0").find_child("PointLight2D").energy = 12.0
		if(lives >= 1):
			roomInstance2.find_child("Torch1").find_child("TorchAnimation").animation = "litfam"
			roomInstance2.find_child("Torch1").find_child("PointLight2D").energy = 12.0
		if(lives >= 3):
			roomInstance2.find_child("Torch2").find_child("TorchAnimation").animation = "litfam"
			roomInstance2.find_child("Torch2").find_child("PointLight2D").energy = 12.0
