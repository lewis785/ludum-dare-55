extends Area2D

class_name SummoningCircle

@export var output_stats: AttributesComponent
@export var ingredients_cap : int = 5

@export var summon_scene : PackedScene

var ingredients = []

# Called when the node enters thegit c scene tree for the first time.
func _ready():
	ingredients.clear()
	clear_stats()

func clear_stats():
	output_stats.defence = 0
	output_stats.luck = 0
	output_stats.speed = 0
	output_stats.strength = 0
	output_stats.vitality = 0

func is_summonable():
	print(ingredients.size())
	if ingredients.size() > ingredients_cap or ingredients.size() == 0:
		return false
	return true

func add_ingredient(ingr):
	ingredients.append(ingr)

func remove_ingredient(ingr):
	ingredients.erase(ingr)

func combine_ingredients():
	if not is_summonable():
		return
	var stats = [0,0,0,0,0]
	
	for ingr : Ingredient in ingredients:
		stats[ingr.type] += ingr.potency
	
	output_stats.defence = stats[0]
	output_stats.luck = stats[1]
	output_stats.speed = stats[2] 
	output_stats.strength = stats[3]
	output_stats.vitality = stats[4]
	
	var summon: Character = summon_scene.instantiate()
	prints(stats)
	
	
	# Summon creature with new stats
	summon.position = position
	summon.attributes_component = output_stats
	summon.add_to_group("summon")
	add_sibling(summon)
	
	for ingr : Ingredient in ingredients:
		ingr.queue_free()

func _on_area_entered(area):
	if area.is_in_group("Ingredient"):   
		add_ingredient(area)


func _on_area_exited(area):
	if area.is_in_group("Ingredient"):
		remove_ingredient(area)
		
func _on_button_pressed():
	combine_ingredients()
