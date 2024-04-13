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
		
func _on_collision_component_body_entered(body):
	if body.is_in_group("Ingredient"):
		add_ingredient(body)

func combine_ingredients():
	pass
