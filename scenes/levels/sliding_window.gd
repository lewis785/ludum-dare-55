extends Node2D

@onready var camera = $Camera2D
@onready var snap_point_0 = $CameraSnaps/SnapPoint0
@onready var snap_point_1 = $CameraSnaps/SnapPoint1
@onready var snap_point_2 = $CameraSnaps/SnapPoint2
@onready var snap_point_3 = $CameraSnaps/SnapPoint3
@onready var snap_point_4 = $CameraSnaps/SnapPoint4
@onready var snap_point_5 = $CameraSnaps/SnapPoint5
@onready var snap_point_6 = $CameraSnaps/SnapPoint6

const ROOM0 = 0
const ROOM1 = 1
const ROOM2 = 2
const ROOM3 = 3
const ROOM4 = 4
const ROOM5 = 5
const ROOM6 = 6

var target = 0
var target_coordinates = Vector2.ZERO	#Initialise the variable so it doesnt complain

func _input(event):
	print(event)
	if(Input.is_key_pressed(KEY_ENTER)):
		target+=1
		
		match target:
			ROOM0:
				target_coordinates = snap_point_0.get_position()
			ROOM1:
				target_coordinates = snap_point_1.get_position()
			ROOM2:
				target_coordinates = snap_point_2.get_position()
			ROOM3:
				target_coordinates = snap_point_3.get_position()
			ROOM4:
				target_coordinates = snap_point_4.get_position()
			ROOM5:
				target_coordinates = snap_point_5.get_position()
			ROOM6:
				target_coordinates = snap_point_6.get_position()
		print(target_coordinates)
	
		camera.set_position(target_coordinates)
