extends DraggableComponent

class_name Ingredient

@export_category("Properties")
enum IngredientTypes {
	GREEN,
	WHITE,
	BLUE,
	BLACK,
	RED,
}
@export var type: IngredientTypes
@export var potency: int = -1
@export var randomise_type: bool = false

@export_category("Components")
@export var sprite: AnimatedSprite2D
@export var label: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	if randomise_type:
		randomise()
	if potency == -1:
		randomise_potency()
	set_type(type)

func set_type(input_type : IngredientTypes):
	type = input_type
	sprite.frame = type
	label.text = stat_info()

func randomise():
	type = IngredientTypes.values()[randi_range(0,IngredientTypes.size()-1)]

func randomise_potency(lower=10, upper=20):
	potency = randi_range(lower,upper)

func title(ingr_type):
	match ingr_type:
		0:
			return "Emerald Powder"
		1:
			return "Diamond Powder"
		2:
			return "Crushed Sapphire"
		3:
			return "Obsidian Salt"
		4:
			return "Ruby Powder"
		_:
			return "Unidentified Object"
	
func description(ingr_type):
	var attribute
	match ingr_type:
		0:
			attribute = "Defence"
		1:
			attribute = "Luck"
		2:
			attribute = "Speed"
		3:
			attribute = "Strength"
		4:
			attribute = "Vitality"
		_:
			return "Unknown Effect"
	return "Boosts %s Attribute" % [attribute]
	
func stat_info():
	var format_info = "%s\n%s"
	var info = format_info % [title(type), description(type)]
	return info
	
func attribute_to_type(attribute : AttributesComponent.Attributes):
	match attribute:
		AttributesComponent.Attributes.DEFENCE:
			set_type(IngredientTypes.GREEN)
		AttributesComponent.Attributes.LUCK:
			set_type(IngredientTypes.WHITE)
		AttributesComponent.Attributes.SPEED:
			set_type(IngredientTypes.BLUE)
		AttributesComponent.Attributes.STRENGTH:
			set_type(IngredientTypes.BLACK)
		AttributesComponent.Attributes.VITALITY:
			set_type(IngredientTypes.RED)

func _on_mouse_entered():
	label.visible = true

func _on_mouse_exited():
	label.visible = false
