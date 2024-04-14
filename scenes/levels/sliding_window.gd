extends Node2D

@onready var camera = $Camera2D
@onready var combat_coordinator = $CombatCoordinator

@export var cameraSpeed: int
@export var lives: int
var roomScene = preload("res://scenes/levels/room.tscn")

var room_instance : Room = roomScene.instantiate()
var old_room : Room

var target_coordinates = Vector2(400,225)
var camera_coordinates = Vector2(400,225)

var target = 0
var room_count = 0
var tempPleaseLewisDontHateMe = 0
var igniteSoundPlayed = 1
var hissSoundPlayed = 1
var walkSoundPlayed = 1
var enableWizard = 0
var flag = 1;

#Camera set to 1.44
func _ready():
	_createNextRoom()
	
		
func _input(_event):
	if(Input.is_key_pressed(KEY_ENTER)):	#UPDATE WHEN BATTLE ENDSS
		room_instance.find_child("RoomMusic").stop()	#Make sure to call this when battle starts!!!
		_createNextRoom()

func _process(delta):
	camera_coordinates = camera.get_position()
	camera.position = camera_coordinates.move_toward(target_coordinates, cameraSpeed*delta)
	camera.set_position(camera.position)
	
	if (target_coordinates != camera_coordinates):
		return
		
	if (!room_instance.is_setup):
		room_instance.setup_room(lives)

	if (old_room != null):
		old_room.queue_free()
		old_room = null
		combat_coordinator.allow_fighting = true	
	

func _createNextRoom():
	room_count += 1
	old_room = room_instance
	room_instance = roomScene.instantiate() as Room
	room_instance.position = Vector2(old_room.position.x + 800, 0)
	add_child(room_instance)
	room_instance.spawn_enemy(room_count)
	
	old_room._set_torches_brightness(0)
	
	target_coordinates = Vector2(400+room_instance.position.x, 225)

	# Move Wizard
	old_room.move_wizard()

func _on_combat_coordinator_fight_started():
	room_instance.find_child("RoomMusic").stop()

func _on_combat_coordinator_fight_lose():
	lives -= 1
	room_instance.setup_room(lives)

func _on_combat_coordinator_fight_win():
	room_instance.find_child("RoomMusic").stop()
	_createNextRoom()
