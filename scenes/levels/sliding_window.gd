extends Node2D

class_name SlidingWindow

signal slide_start()
signal slide_stop()
signal reward_received()

@onready var camera = $Camera2D
@onready var combat_coordinator = $CombatCoordinator
@onready var win_music = $WinMusic
@onready var lose_music = $LoseMusic
@onready var fight_music = $FightMusic
@onready var game_over_bar = $Overlay/GameOverBar

@export var cameraSpeed: int
@export var lives: int
var roomScene = preload("res://scenes/levels/room.tscn")

var room_instance : Room = roomScene.instantiate()
var old_room : Room

var target_coordinates = Vector2(400,225)
var camera_coordinates = Vector2(400,225)

var sliding : bool = false
var retrievingReward = false
var retrievingRemains = false
var retrieving_speed : float = 500.0
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

func _process(delta):
	camera_coordinates = camera.get_position()
	camera.position = camera_coordinates.move_toward(target_coordinates, cameraSpeed*delta)
	camera.set_position(camera.position)
	
	if (target_coordinates != camera_coordinates):
		return

	if (target_coordinates == camera_coordinates and sliding):
		sliding = false
		slide_stop.emit()
		
	if (!room_instance.is_setup):
		room_instance.setup_room(lives)

	if (old_room != null):
		old_room.queue_free()
		old_room = null
		#combat_coordinator.allow_fighting = true	
	if (retrievingReward == true):
		if(room_instance.find_child("ReturnStatsAnimation").find_child("LeftOrb").find_child("PathFollow2D").progress_ratio >= 0.95):
			retrievingReward = false
			room_instance.find_child("ReturnStatsAnimation").visible = false
			reward_received.emit()
		room_instance.find_child("ReturnStatsAnimation").find_child("LeftOrb").find_child("PathFollow2D").progress += retrieving_speed*delta
		
	if (retrievingRemains == true):
		if(room_instance.find_child("ReturnRemainsAnimation").find_child("Orb").find_child("PathFollow2D").progress_ratio >= 0.95):
			retrievingRemains = false
			room_instance.find_child("ReturnRemainsAnimation").visible = false
		room_instance.find_child("ReturnRemainsAnimation").find_child("Orb").find_child("PathFollow2D").progress += retrieving_speed*delta
		room_instance.find_child("ReturnRemainsAnimation").find_child("Orb").find_child("PathFollow2D").progress += retrieving_speed*delta

func _createNextRoom():
	room_count += 1
	old_room = room_instance
	room_instance = roomScene.instantiate() as Room
	room_instance.position = Vector2(old_room.position.x + 800, 0)
	add_child(room_instance)
	room_instance.spawn_enemy(room_count)
	
	old_room._set_torches_brightness(0)
	
	target_coordinates = Vector2(400+room_instance.position.x, 225)
	sliding = true
	slide_start.emit()

	# Move Wizard
	old_room.move_wizard()

func _on_combat_coordinator_fight_started():
	fight_music.play()

func _on_combat_coordinator_fight_lose():
	fight_music.stop()
	lose_music.play()
	lives -= 1
	room_instance.setup_room(lives)
	
	if(lives < 1):
		game_over_bar.visible = true
		return
	room_instance.find_child("ReturnRemainsAnimation").visible = true
	retrievingRemains = true
	await get_tree().create_timer(2.0).timeout
	combat_coordinator.allow_fighting = true	

func _on_combat_coordinator_fight_win():
	fight_music.stop()
	win_music.play()
	room_instance.find_child("ReturnStatsAnimation").visible = true
	retrievingReward = true


func _on_reward_received():
	_createNextRoom()
