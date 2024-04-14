extends Area2D

@export var ingredients_cap : int = 5
@export var summon_scene : PackedScene

var ingredients = []

# Called when the node enters thegit c scene tree for the first time.
func _ready():
	ingredients.clear()

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
	
	var summon: Character = summon_scene.instantiate()
	
	# Summon creature with new stats
	summon.position = position
	var attributes = summon.get_node("AttributesComponent")
	attributes.defence = stats[0]
	attributes.luck = stats[1]
	attributes.speed = stats[2] 
	attributes.strength = stats[3]
	attributes.vitality = stats[4]

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
