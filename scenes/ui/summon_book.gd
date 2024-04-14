extends Node2D

@export var summoning_circle : SummoningCircle
@export var arrow_sprite : Sprite2D
@onready var base_x : float = summoning_circle.position.x
@export var base_y : float = 160
@export var speed : float = 1.0
@export var height : int = 280

var tween : Tween
var book_raised : bool = false

func _ready():
	book_raised = false
	
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
	tween = self.create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "global_position:y", 1000, speed).as_relative().set_ease(Tween.EASE_IN_OUT)
	book_raised = false

func toggle_position():
	if book_raised:
		lower_book()
	else:
		raise_book()
	
func _on_button_pressed():
	if summoning_circle.is_summonable():
		hide_book()

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if tween == null or !tween.is_running():
		if event is InputEventMouseButton and event.pressed:
			toggle_position()
