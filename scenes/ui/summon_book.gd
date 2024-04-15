extends Node2D

class_name SummonBook

signal book_up
signal book_down

@export var summoning_circle : SummoningCircle
@export var arrow_sprite : Sprite2D
@export var start_coords : Vector2 = Vector2(620,560)
@export var displ_coords : Vector2 = Vector2(400,560)
@export var speed : float = 1.0
@export var height : int = 280

var tween : Tween
var book_raised : bool = false
var inventory = null
var summon_active : bool = true
var sigil_drawn : bool = false

###### BOOK SETUP ######
func _ready():
	position = start_coords
	book_raised = false
	store_book()
	_connect_nodes()

func _connect_nodes():
	var sliding_window : SlidingWindow = find_parent("SlidingWindow")
	sliding_window.connect("slide_stop", Callable(self, "_on_sliding_window_slide_stop"))
	
	var combat_coordinator : CombatCoordinator = sliding_window.find_child("CombatCoordinator")
	combat_coordinator.connect("fight_lose", Callable(self, "_on_combat_coordinator_fight_lose"))

###### BOOK INVENTORY ######
func reset_book():
	if inventory != null:
		populate_book()
	unhide_book()
	raise_book()
	
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

###### MOVING BOOK ######
func raise_book():
	tween = self.create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "global_position:y", -height, speed).as_relative().set_ease(Tween.EASE_IN_OUT)
	var arrow_tween = arrow_sprite.create_tween().set_trans(Tween.TRANS_SINE)
	arrow_tween.tween_property(arrow_sprite, "rotation_degrees", 180, speed).as_relative().set_ease(Tween.EASE_IN_OUT)
	if !sigil_drawn:
		find_child("SummoningCircle").find_child("Sprite2D").play("Spawn")
		find_child("SummoningCircleAudio").play()
		sigil_drawn = true
	book_raised = true
	book_up.emit()

func lower_book():
	tween = self.create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "global_position:y", height, speed).as_relative().set_ease(Tween.EASE_OUT)
	var arrow_tween = arrow_sprite.create_tween().set_trans(Tween.TRANS_SINE)
	arrow_tween.tween_property(arrow_sprite, "rotation_degrees", 180, speed).as_relative().set_ease(Tween.EASE_IN_OUT)
	book_raised = false
	book_down.emit()

func hide_book():
	tween = self.create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "global_position:y", 1000, speed).as_relative().set_ease(Tween.EASE_IN_OUT)
	#book_raised = false
	#visible = false
	summon_active = false

func unhide_book():
	if tween != null and tween.is_running():
		print("TWEEN KILL")
		tween.kill()
	position = start_coords
	visible = true
	book_raised = false
	summon_active = true
	book_down.emit()

func toggle_position():
	if book_raised:
		lower_book()
	else:
		raise_book()

###### EVENT HANDLING ######
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

func _on_combat_coordinator_fight_lose():
	reset_book()

# Called when fight won
func _on_sliding_window_slide_stop():
	store_book()
	reset_book()
