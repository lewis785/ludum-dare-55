extends Node2D

class_name SummonBook

@export var summoning_circle : SummoningCircle
@export var arrow_sprite : Sprite2D
@onready var base_x : float = summoning_circle.position.x
@export var base_y : float = 160
@export var start_coords : Vector2
@export var speed : float = 1.0
@export var height : int = 280

var tween : Tween
var book_raised : bool = false
var inventory = null
var summon_active : bool = true


func _ready():
	position = start_coords
	book_raised = false
	#populate_book()
	store_book()

func reset_book():
	if inventory != null:
		populate_book()
	unhide_book() 
	
func populate_book():
	var i = 0
	for child_node in find_child("OpenBook").find_children("BookLine*"):
		var book_line : BookLine = child_node
		var temp_inv = inventory.slice(i,i+5)
		book_line.spawn_inventory(temp_inv)
		i+=5
	
func store_book():
	inventory = []
	for child_node in find_child("OpenBook").find_children("BookLine*"):
		var book_line : BookLine = child_node
		inventory = inventory + book_line.get_ingredients()
	
func raise_book():
	tween = self.create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "global_position:y", -height, speed).as_relative().set_ease(Tween.EASE_IN_OUT)
	var arrow_tween = arrow_sprite.create_tween().set_trans(Tween.TRANS_SINE)
	arrow_tween.tween_property(arrow_sprite, "rotation_degrees", 180, speed).as_relative().set_ease(Tween.EASE_IN_OUT)
	book_raised = true

func lower_book():
	tween = self.create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "global_position:y", height, speed).as_relative().set_ease(Tween.EASE_OUT)
	var arrow_tween = arrow_sprite.create_tween().set_trans(Tween.TRANS_SINE)
	arrow_tween.tween_property(arrow_sprite, "rotation_degrees", 180, speed).as_relative().set_ease(Tween.EASE_IN_OUT)
	book_raised = false

func hide_book():
	#tween = self.create_tween().set_trans(Tween.TRANS_SINE)
	#tween.tween_property(self, "global_position:y", 1000, speed).as_relative().set_ease(Tween.EASE_IN_OUT)
	#book_raised = false
	visible = false
	summon_active = false

func unhide_book():
	#if tween != null and tween.is_running():
		#print("TWEEN KILL")
		#tween.kill()
	position = start_coords
	visible = true
	book_raised = false
	summon_active = true

func toggle_position():
	if book_raised:
		lower_book()
	else:
		raise_book()

func _on_button_pressed():
	if summoning_circle.is_summonable():
		lower_book()
		hide_book()

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if tween == null or !tween.is_running():
		if event is InputEventMouseButton and event.pressed:
			toggle_position()

func _input(_event):
	if(Input.is_key_pressed(KEY_SPACE)):	#UPDATE WHEN BATTLE ENDSS
		
		if !summon_active:
			reset_book()
