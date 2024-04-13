extends DraggableComponent

class_name Ingredient

@export_category("Properties")
enum IngredientTypes {
	WHITE,
	RED,
	BLUE,
	GREEN,
	BLACK
}
@export var type: IngredientTypes
#@export_enum(IngredientTypes) var type: int

@export_category("Components")
@export var sprite: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.frame = type
	#generate_stats()

#func generate_stats():
	#pass
