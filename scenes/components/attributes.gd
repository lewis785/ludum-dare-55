extends Node

@export_group("Attributes")
@export_range(0, 100) var defence = 0:
	set(value):
		defence = clamp(value, 0, 100)
	get:
		defence
@export_range(0, 100) var vitality = 0:
	set(value):
		vitality = clamp(value, 0, 100)
	get:
		vitality
@export_range(0, 100) var luck = 0:
	set(value):
		luck = clamp(value, 0, 100)
	get:
		luck
@export_range(0, 100) var speed = 0:
	set(value):
		speed = clamp(value, 0, 100)
	get:
		speed
@export_range(0, 100) var strength = 0:
	set(value):
		strength = clamp(value, 0, 100)
	get:
		strength
		
@export_group("Resistances")
@export_range(-100, 100) var slashing = 0:
	set(value):
		slashing = clamp(value, -100, 100)
	get:
		slashing
@export_range(-100, 100) var bludgening = 0:
	set(value):
		bludgening = clamp(value, -100, 100)
	get:
		bludgening
@export_range(-100, 100) var magic = 0:
	set(value):
		slashing = clamp(value, -100, 100)
	get:
		slashing	
