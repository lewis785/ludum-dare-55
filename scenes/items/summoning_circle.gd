extends Area2D

@export var sprite: AnimatedSprite2D

@export var ingredients = []

# Called when the node enters the scene tree for the first time.
func _ready():
	ingredients = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func add_ingredient(ingr):
	ingredients.append(ingr)
	
func remove_ingredient(ingr):
	ingredients.erase(ingr)

func combine_ingredients():
	pass


func _on_area_entered(area):
	if area.is_in_group("Ingredient"):
		add_ingredient(area)


func _on_area_exited(area):
	if area.is_in_group("Ingredient"):
		remove_ingredient(area)
