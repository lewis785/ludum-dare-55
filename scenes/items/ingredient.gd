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
@export var randomise_type: bool = false

@export_category("Components")
@export var sprite: AnimatedSprite2D
@export var label: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	if randomise_type:
		randomise()
	if potency == -1:
		potency = randi_range(10,20)
	sprite.frame = type
	label.text = stat_info()
	label.scale = Vector2(1,1)
	print()
	#print(stat_info())

func randomise():
	type = IngredientTypes.values()[randi_range(0,IngredientTypes.size()-1)]

func title(type):
	match type:
		0:
			return "Diamond Powder"
		1:
			return "Ruby Powder"
		2:
			return "Crushed Sapphire"
		3:
			return "Emerald Powder"
		4:
			return "Obsidian Salt"
		_:
			return "Unidentified Object"
	
func description(type):
	var attribute
	match type:
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

func _on_mouse_entered():
	label.visible = true


func _on_mouse_exited():
	label.visible = false
