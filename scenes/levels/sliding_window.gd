extends Node2D

@onready var camera = $Camera2D


@export var roomNumber: int
@export var cameraSpeed: int
var roomScene = load("res://scenes/levels/room.tscn")


var target = 0
var target_coordinates = Vector2(400,225)	#Initialise the variable so it doesnt complain
var camera_coordinates = Vector2(400,225)
var rooms: Array[PackedScene] = []

#Camera set to 1.44
func _ready():
	print("creating room ")
	for i in range(roomNumber):
		print(i)
		var instance = roomScene.instantiate()
		instance.position = Vector2((800*i), 0)
		rooms.push_front(instance)
		add_child(instance)
		
func _input(event):
	print(event)
	if(Input.is_key_pressed(KEY_ENTER)):	#UPDATE WHEN BATTLE ENDS
		if(target<=roomNumber-2):
			print(target)
			print(roomNumber)
			target+=1
			target_coordinates = Vector2(400+(800*target), 225)


func _process(delta):
	camera_coordinates = camera.get_position()
	camera.position = camera_coordinates.lerp(target_coordinates, cameraSpeed*delta)
	camera.set_position(camera.position)
