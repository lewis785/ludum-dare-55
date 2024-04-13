extends Node

class_name AttributesComponent

@export_group("Attributes")
@export_range(0, 100) var defence = 0:
	set(value):
		defence = clamp(value, 0, 100)
	get:
		return defence
@export_range(0, 100) var luck = 0:
	set(value):
		luck = clamp(value, 0, 100)
	get:
		return luck
@export_range(0, 100) var speed = 0:
	set(value):
		speed = clamp(value, 0, 100)
	get:
		return speed
@export_range(0, 100) var strength = 0:
	set(value):
		strength = clamp(value, 0, 100)
	get:
		return strength
@export_range(0, 100) var vitality = 0:
	set(value):
		vitality = clamp(value, 0, 100)
	get:
		return vitality

enum Attributes {
	DEFENCE,
	LUCK,
	SPEED,
	STRENGTH,
	VITALITY
}

func get_attribute_value(attribute: Attributes):
	match attribute:
		Attributes.DEFENCE:
			return defence
		Attributes.LUCK:
			return luck
		Attributes.SPEED:
			return speed
		Attributes.STRENGTH:
			return strength
		Attributes.VITALITY:
			return vitality
	assert("Invalid attribute provided")

@export_group("Resistances")
@export_range(-100, 100) var slashing = 0:
	set(value):
		slashing = clamp(value, -100, 100)
	get:
		return slashing
@export_range(-100, 100) var bludgening = 0:
	set(value):
		bludgening = clamp(value, -100, 100)
	get:
		return bludgening
@export_range(-100, 100) var magic = 0:
	set(value):
		slashing = clamp(value, -100, 100)
	get:
		return slashing	

enum DamageTypes {
	SLASHING,
	BLUDGENING,
	MAGIC
}

func get_resistance_value(type: DamageTypes):
	match type:
		DamageTypes.SLASHING: 
			return slashing
		DamageTypes.BLUDGENING:
			return bludgening
		DamageTypes.MAGIC:
			return magic
	return 0
