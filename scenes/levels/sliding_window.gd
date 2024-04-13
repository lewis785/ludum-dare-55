extends Node2D

@onready var camera = $Camera2D
@export var cameraSpeed: int
@export var lives: int
@export var wizardSpeed: int

var roomScene = preload("res://scenes/levels/room.tscn")

var roomInstance1 = roomScene.instantiate()
var roomInstance2 = roomScene.instantiate()

var target_coordinates = Vector2(400,225)	#Initialise the variable so it doesnt complain
var camera_coordinates = Vector2(400,225)

var target = 0
var roomsMade = -1 #Has to be negative for initial room to be instantiated.
var tempPleaseLewisDontHateMe = 0
var igniteSoundPlayed = 1
var hissSoundPlayed = 1
var walkSoundPlayed = 1
var enableWizard = false

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
	if(enableWizard == true):
		roomInstance1.find_child("Node2D").find_child("Path2D").find_child("PathFollow2D").progress+= wizardSpeed*delta
		roomInstance2.find_child("Node2D").find_child("Path2D").find_child("PathFollow2D").progress+= wizardSpeed*delta
		print(wizardSpeed*delta)
		
func _createNextRoom(nextRoom):
	var roomInstance = roomInstance1 if nextRoom % 2 == 0 else roomInstance2
	var notRoomInstance = roomInstance2 if nextRoom % 2 == 0 else roomInstance1

	if(nextRoom > roomsMade):
		roomInstance.position = Vector2((800*nextRoom), 0)
		add_child(roomInstance)
		roomsMade += 1
		igniteSoundPlayed = 0
		if(tempPleaseLewisDontHateMe > 0):
			hissSoundPlayed = 0
			walkSoundPlayed = 0
		
	if(nextRoom == roomsMade):
		if(hissSoundPlayed == 0):
			roomInstance.find_child("Torch0").find_child("Extinguish").play()
			hissSoundPlayed = 1
			_setTorchesBrightness(notRoomInstance, 0.0)
		if(walkSoundPlayed == 0):
			roomInstance.find_child("Torch0").find_child("Walking").play()
			walkSoundPlayed = 1
			enableWizard = true
		
		target_coordinates = Vector2(400+(800*nextRoom), 225)
		if(target_coordinates == camera_coordinates):
			tempPleaseLewisDontHateMe+=1
			if((tempPleaseLewisDontHateMe > 2) and (target_coordinates == camera_coordinates) and igniteSoundPlayed == 0):
				enableWizard = false
				roomInstance.find_child("Torch0").find_child("Ignite").play()	
				_setTorchesBrightness(roomInstance, 10.0)
				tempPleaseLewisDontHateMe = 0
				igniteSoundPlayed = 1
	
func _setTorchesBrightness(instance: Node, brightness):
		if(brightness == 0.0):
			instance.find_child("Torch0").find_child("TorchAnimation").animation = "notLitFam"
			instance.find_child("Torch0").find_child("PointLight2D").energy = 0.0
			instance.find_child("Torch1").find_child("TorchAnimation").animation = "notLitFam"
			instance.find_child("Torch1").find_child("PointLight2D").energy = 0.0
			instance.find_child("Torch2").find_child("TorchAnimation").animation = "notLitFam"
			instance.find_child("Torch2").find_child("PointLight2D").energy = 0.0
		else:
			if(lives >= 2):
				instance.find_child("Torch0").find_child("TorchAnimation").animation = "litfam"
				instance.find_child("Torch0").find_child("PointLight2D").energy = brightness
			if(lives >= 1):
				instance.find_child("Torch1").find_child("TorchAnimation").animation = "litfam"
				instance.find_child("Torch1").find_child("PointLight2D").energy = brightness
			if(lives >= 3):
				instance.find_child("Torch2").find_child("TorchAnimation").animation = "litfam"
				instance.find_child("Torch2").find_child("PointLight2D").energy = brightness
