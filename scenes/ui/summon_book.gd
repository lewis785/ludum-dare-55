extends Node2D

@export var summoning_circle : SummoningCircle
@onready var base_x : float = summoning_circle.position.x
@export var base_y : float = 160
@export var speed : int = 3
@export var height : int = 20

var tween_y : Tween

func _ready():
	pass

func _on_button_pressed():
	if summoning_circle.is_summonable():
		tween_y = self.create_tween().set_trans(Tween.TRANS_SINE)
		tween_y.tween_property(self, "global_position:y", 1000, speed).as_relative().set_ease(Tween.EASE_IN)
