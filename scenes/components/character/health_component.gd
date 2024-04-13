extends Node

@export var attributes: AttributesComponent

@export var base_health: float = 0.0;
var max_health: float
var health: float = 0.0;

func _ready():
	max_health = base_health + attributes.vitality
	health = max_health
	print("Health: " + str(health).pad_decimals(2))
	
var time = 0
func _process(delta):
	time += delta
	if time > 1:
		var attack = Attack.new();
		attack.damage = 20
		attack.type = AttributesComponent.DamageTypes.SLASHING
		damage(attack)
		# Reset timer
		time = 0
	
	
func damage(value: Attack):
	health -= _calculate_damage(value)
	print("Health: " + str(health))
	if health <= 0:
		get_parent().queue_free()

func heal():
	health = max_health	
	
func _calculate_damage(attack: Attack):
	var defence: float = (100 - attributes.defence) / 100.0; 
	var resistance: float = (100 - attributes.get_resistance_value(attack.type)) / 100.0
	var damage = attack.damage
	
	print("defence: " + str(defence) + " resistance: " + str(resistance) + " damage: " + str(damage))
	print("Actual damage: " + str(damage * defence * resistance))
	return damage * defence * resistance
	
