extends Node2D

var ingredient = preload("res://scenes/items/ingredient.tscn")
#@export var ingredient : PackedScene
@export var summoning_circle : SummoningCircle

# Coordinates to spawn
var coords = [Vector2(-110.0,5.0), Vector2(-55.0,0.0), Vector2(0.0,-2.0), Vector2(55.0,0.0), Vector2(110.0,5.0)]

func _ready():
	spawn_ingredients()

			
func spawn_ingredients():
	for coord in coords:
		var new_ingr = ingredient.instantiate()
		add_child(new_ingr)
		new_ingr.position = coord
