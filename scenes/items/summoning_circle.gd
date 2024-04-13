extends Area2D

#@export var sprite: AnimatedSprite2D

@export var ingredients = []
@export var output_stats: AttributesComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	ingredients.clear()    
	#output_stats.defence = 0
	#output_stats.luck = 0
	#output_stats.speed = 0
	#output_stats.strength = 0
	#output_stats.vitality = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func add_ingredient(ingr):
	ingredients.append(ingr)
	
func remove_ingredient(ingr):
	ingredients.erase(ingr)

func combine_ingredients():
	var stats = [0,0,0,0,0]
	
	for ingr : Ingredient in ingredients:
		stats[ingr.type] += 10
		#print(ingr.type)
	
	output_stats.defence = stats[0]
	output_stats.luck = stats[1]
	output_stats.speed = stats[2]
	output_stats.strength = stats[3]
	output_stats.vitality = stats[4]
	
	#print(stats)
	#print(output_stats.defence)
	#print(output_stats.luck)
	#print(output_stats.speed)
	#print(output_stats.strength)
	#print(output_stats.vitality)


func _on_area_entered(area):
	if area.is_in_group("Ingredient"):   
		add_ingredient(area)


func _on_area_exited(area):
	if area.is_in_group("Ingredient"):
		remove_ingredient(area)
		
		
#func _input(event):
	#print(event)
	#if(Input.is_key_pressed(KEY_SPACE)):
		#combine_ingredients()
