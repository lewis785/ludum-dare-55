extends Node2D
@onready var cinematic = $TextureRect/Cinematic
@onready var start_button = $TextureRect/StartButton
@onready var credits_button = $TextureRect/CreditsButton
@onready var quit_button = $TextureRect/QuitButton
@onready var how_to_button = $TextureRect/HowToButton
@onready var credits_page = $CreditsPage
@export var config: ConfigComponent


func _ready():
	var music_muted: bool
	var fx_muted: bool 
	music_muted = config.load_value("sound", "music_muted", false)
	fx_muted = config.load_value("sound", "fx_muted", false)
	set_music_muted(music_muted)
	set_fx_muted(fx_muted)

func _on_start_button_pressed():
	cinematic.visible = true
	start_button.visible = false
	credits_button.visible = false
	quit_button.visible = false
	how_to_button.visible = false
	cinematic.play()
	await get_tree().create_timer(4.8).timeout
	get_tree().change_scene_to_file("res://scenes/levels/sliding_window.tscn")


func _on_main_menu_button_pressed():
	credits_page.visible = false


func _on_credits_button_pressed():
	credits_page.visible = true


func _on_quit_button_pressed():
	get_tree().quit()

func set_music_muted(is_muted):
	config.save_value("sound", "music_muted", is_muted)
	AudioServer.set_bus_mute(2, is_muted)

func set_fx_muted(is_muted):
	config.save_value("sound", "fx_muted", is_muted)
	AudioServer.set_bus_mute(1, is_muted)
