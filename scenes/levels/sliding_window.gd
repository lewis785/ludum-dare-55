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
		room_instance.find_child("AudioStreamPlayer2D").stop()	#Make sure to call this when battle starts!!!
		_createNextRoom()

func _process(delta):
	camera_coordinates = camera.get_position()
	camera.position = camera_coordinates.move_toward(target_coordinates, cameraSpeed*delta)
	camera.set_position(camera.position)
	
	if (target_coordinates == camera_coordinates):
		if (!room_instance.is_setup):
			room_instance.setup_room(lives)
	
		if (old_room != null):
			#old_room.queue_free()
			old_room = null
	#if(enableWizard == 1):
		#roomInstance1.find_child("Node2D").find_child("Path2D").find_child("PathFollow2D").progress+= wizardSpeed*delta
	#if(enableWizard == 2):
		#roomInstance2.find_child("Node2D").find_child("Path2D").find_child("PathFollow2D").progress+= wizardSpeed*delta

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

	
	
	
	
	
	#var roomInstance = roomInstance1 if nextRoom % 2 == 0 else roomInstance2
	#var notRoomInstance = roomInstance2 if nextRoom % 2 == 0 else roomInstance1
	#if (nextRoom % 2 == 0):
		#flag = 2
	#else:
		#flag = 1
		#
	#if(nextRoom > roomsMade):
		#roomInstance.position = Vector2((800*nextRoom), 0)
		#add_child(roomInstance)
		#roomsMade += 1
		#igniteSoundPlayed = 0
		#if(tempPleaseLewisDontHateMe > 0):
			#hissSoundPlayed = 0
			#walkSoundPlayed = 0
		#
	#if(nextRoom == roomsMade):
		#if(hissSoundPlayed == 0):
			#roomInstance.find_child("Torch0").target+=1find_child("Extinguish").play()
			#hissSoundPlayed = 1
			##_setTorchesBrightness(notRoomInstance, 0.0)
		#if(walkSoundPlayed == 0):
			#roomInstance.find_child("Torch0").find_child("Walking").play()
			#walkSoundPlayed = 1
			#
			#enableWizard = flag
			#notRoomInstance.find_child("Node2D").find_child("Path2D").find_child("PathFollow2D").find_child("Wizard").find_child("PointLight2D").set_enabled(true)
			#notRoomInstance.find_child("Node2D").find_child("Path2D").find_child("PathFollow2D").find_child("Wizard").visible = true
		#
		#target_coordinates = Vector2(400+(800*nextRoom), 225)
		#if(target_coordinates == camera_coordinates):
			#tempPleaseLewisDontHateMe+=1
			#if(tempPleaseLewisDontHateMe%flickerDelay == 0):
				#print(tempPleaseLewisDontHateMe)
				#_setTorchesBrightness(roomInstance, maxBrightness)
			#if((tempPleaseLewisDontHateMe > 2) and (target_coordinates == camera_coordinates) and igniteSoundPlayed == 0):
				#enableWizard = 0
				#notRoomInstance.find_child("Node2D").find_child("Path2D").find_child("PathFollow2D").find_child("Wizard").find_child("PointLight2D").set_enabled(false)
				#notRoomInstance.find_child("Node2D").find_child("Path2D").find_child("PathFollow2D").find_child("Wizard").visible = false
				#roomInstance1.find_child("Node2D").find_child("Path2D").find_child("PathFollow2D").progress = 0
				#roomInstance2.find_child("Node2D").find_child("Path2D").find_child("PathFollow2D").progress = 0
				#roomInstance.find_child("Torch0").find_child("Ignite").play()	
				#tempPleaseLewisDontHateMe = 0
				#roomInstance1.find_child("AudioStreamPlayer2D").play()
				#roomInstance.find_child("Summon-screen").find_child("SummoningCircle").find_child("Sprite2D").play("Spawn")
				#roomInstance1.find_child("SummoningCircleAudio").play()
				#igniteSoundPlayed = 1

func _on_combat_coordinator_fight_started():
	room_instance.find_child("AudioStreamPlayer2D").stop()	#Make sure to call this when battle starts!!!

func _on_combat_coordinator_fight_lose():
	pass # Replace with function body.

func _on_combat_coordinator_fight_win():
	pass
