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
@export var potency: int = -1

@export_category("Components")
@export var sprite: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.frame = type
	if potency == -1:
		potency = randi_range(10,20)

