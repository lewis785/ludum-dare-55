extends Node

@export var attributes: AttributesComponent

var base_health: float = 0.0;
var max_health: float
var health: float = 0.0;

func _init():
	max_health = base_health + attributes.vitality
	health = max_health
	
func damage(value: Attack):
	health -= _calculate_damage(value)
	if health <= 0:
		get_parent().queue_free()

func heal():
	health = max_health	
	
func _calculate_damage(attack: Attack):
	var defence = (100 - attributes.defence) / 100; 
	var resistance = (100 - attributes.get_resistance_value(attack.type))
	var damage = attack.damage
	
	print("defence: " + defence + " resistance: " + resistance + " damage: " + damage)
	return damage * defence * resistance
	
