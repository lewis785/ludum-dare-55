extends Node2D

@export var summoning_circle : SummoningCircle
@onready var base_x : int = summoning_circle.position.x
@export var base_y : int = 160
@export var speed : int = 5
@export var height : int = 20

var tween_y : Tween

func _ready():
	position = Vector2(base_x,base_y)
	var half_height = height/2
	
	tween_y = self.create_tween().set_trans(Tween.TRANS_SINE).set_loops()
	tween_y.tween_property(self, "global_position:y", half_height, speed).as_relative().set_ease(Tween.EASE_IN)
	tween_y.tween_property(self, "global_position:y", half_height, speed).as_relative().set_ease(Tween.EASE_OUT)
	tween_y.tween_property(self, "global_position:y", -half_height, speed).as_relative().set_ease(Tween.EASE_IN)
	tween_y.tween_property(self, "global_position:y", -half_height, speed).as_relative().set_ease(Tween.EASE_OUT)

func _on_button_pressed():
	if summoning_circle.is_summonable():
		tween_y.kill()
		tween_y = self.create_tween().set_trans(Tween.TRANS_SINE)
		tween_y.tween_property(self, "global_position:y", -2000, speed).as_relative().set_ease(Tween.EASE_IN)
