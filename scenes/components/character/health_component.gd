extends Node

class_name HealthComponent

const FLOATING_LABEL = preload("res://scenes/ui/floating_label.tscn")
signal damaged(damage: int, crit: bool)

@export var attributes: AttributesComponent

@export var base_health: float = 0.0;
var max_health: float
var health: float = 0.0;

func _ready():
	max_health = base_health + attributes.vitality
	health = max_health
	print("Health: " + str(health).pad_decimals(2))
		
func damage(value: Attack):
	var damage = _calculate_damage(value)
	health -= damage
	print("Health: " + str(health))
	
	
	damaged.emit(damage, value.crit)

	if health <= 0:
		get_parent().queue_free()

func heal():
	health = max_health	
	
func _calculate_damage(attack: Attack):
	var defence: float = (100 - attributes.defence) / 100.0; 
	var resistance: float = (100 - attributes.get_resistance_value(attack.type)) / 100.0
	var damage = attack.damage
	var crit_modifier = 2 if attack.crit else 1
	
	print("defence: " + str(defence) + " resistance: " + str(resistance) + " damage: " + str(damage) + " crit: " + str(crit_modifier))
	print("Actual damage: " + str(round(damage * defence * resistance * crit_modifier)))
	return round(damage * defence * resistance * crit_modifier)
	
