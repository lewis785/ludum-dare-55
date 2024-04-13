extends Area2D

@export var output_stats: AttributesComponent
@export var ingredients_cap : int = 5

@export var creature_summon : Character

var ingredients = []

# Called when the node enters thegit c scene tree for the first time.
func _ready():
	ingredients.clear()

func clear_stats():
	output_stats.defence = 0
	output_stats.luck = 0
	output_stats.speed = 0
	output_stats.strength = 0
	output_stats.vitality = 0

func add_ingredient(ingr):
	ingredients.append(ingr)
	
func remove_ingredient(ingr):
	ingredients.erase(ingr)

func combine_ingredients():
	if ingredients.size() > ingredients_cap or ingredients.size() == 0:
		return
	var stats = [0,0,0,0,0]
	
	for ingr : Ingredient in ingredients:
		stats[ingr.type] += ingr.potency
	
	output_stats.defence = stats[0]
	output_stats.luck = stats[1]
	output_stats.speed = stats[2] 
	output_stats.vitality = stats[4]
	
	# Summon creature with new stats
	creature_summon.visible = false
	creature_summon.position = position
	creature_summon.attributes_component = output_stats
	creature_summon.visible = true
	
	for ingr : Ingredient in ingredients:
		ingr.queue_free()

func _on_area_entered(area):
	if area.is_in_group("Ingredient"):   
		add_ingredient(area)


func _on_area_exited(area):
	if area.is_in_group("Ingredient"):
		remove_ingredient(area)
		
		
func _input(event):
	if(Input.is_key_pressed(KEY_SPACE)):
		combine_ingredients()
