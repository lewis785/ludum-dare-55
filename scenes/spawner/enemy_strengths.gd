extends Node2D

class_name EnemyStrengths

@onready var sigil_left: AnimatedSprite2D = $SigilLeft
@onready var sigil_right: AnimatedSprite2D = $SigilRight


@export var primary: AttributesComponent.Attributes = AttributesComponent.Attributes.STRENGTH:
	set(value):
		primary = value
		if is_node_ready():
			_set_sprites()
@export var secondary: AttributesComponent.Attributes = AttributesComponent.Attributes.LUCK:
	set(value):
		secondary = value
		print("UPDATING SECONDARY")
		if is_node_ready():
			_set_sprites()

func _ready():
	_set_sprites()

func _set_sprites():
	sigil_left.animation = _get_sigil(primary)
	sigil_right.animation = _get_sigil(secondary)

func _get_sigil(attribute: AttributesComponent.Attributes):
	match attribute:
		AttributesComponent.Attributes.STRENGTH:
			return "Strength1"
		AttributesComponent.Attributes.SPEED:
			return "Speed1"
		AttributesComponent.Attributes.VITALITY:
			return "Health1"
		AttributesComponent.Attributes.LUCK:
			return "Luck1"
		AttributesComponent.Attributes.DEFENCE:
			return "Defence1"
		
		
	
	


