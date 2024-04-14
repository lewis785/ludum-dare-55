extends Node2D

class_name BookLine

var ingredient = preload("res://scenes/items/ingredient.tscn")
#@export var ingredient : PackedScene
@export var summoning_circle : SummoningCircle
@export var base_type : Ingredient.IngredientTypes

# Coordinates to spawn
var coords = [Vector2(-110.0,5.0), Vector2(-55.0,0.0), Vector2(0.0,-2.0), Vector2(55.0,0.0), Vector2(110.0,5.0)]

func _ready():
	spawn_ingredients()
			
func spawn_ingredients():
	for coord in coords:
		spawn_ingredient(base_type, null, coord)

func spawn_inventory(ingredients):
	var i = 0
	for ingr : Ingredient in ingredients:
		ingr.visible = true
		ingr.position = coords[i]
		i+=1

func spawn_ingredient(type, potency, coord):
	var new_ingr : Ingredient = ingredient.instantiate() as Ingredient
	add_child(new_ingr)
	new_ingr.set_type(type)
	new_ingr.position = coord
	if potency:
		new_ingr.potency = potency

func get_ingredients():
	var inventory = []
	for ingr in get_children():
		inventory.append(ingr)
	return inventory
