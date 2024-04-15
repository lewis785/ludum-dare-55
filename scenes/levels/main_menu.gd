extends Node2D
@onready var cinematic = $TextureRect/Cinematic
@onready var start_button = $TextureRect/StartButton
@onready var credits_button = $TextureRect/CreditsButton
@onready var quit_button = $TextureRect/QuitButton
@onready var how_to_button = $TextureRect/HowToButton
@onready var credits_page = $CreditsPage


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
