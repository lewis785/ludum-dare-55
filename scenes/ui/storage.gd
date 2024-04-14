extends Node2D

var ingredient = preload("res://scenes/items/ingredient.tscn")
@export var summoning_circle : SummoningCircle

# Coordinates to spawn
var x_coords = [-54, -18, 18, 54]
var y_coords = [-53, 1, 55]

func _ready():
	for x in range(x_coords.size()):
		for y in range(y_coords.size()):
			var new_ingr = ingredient.instantiate()
			add_child(new_ingr)
			new_ingr.position = Vector2(x_coords[x],y_coords[y])


func _on_button_pressed():
	if summoning_circle.is_summonable():
		var tween_y = self.create_tween().set_trans(Tween.TRANS_SINE)
		tween_y.tween_property(self, "global_position:y", -2000, 2).as_relative().set_ease(Tween.EASE_IN)
