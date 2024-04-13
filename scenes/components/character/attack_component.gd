extends Node

class_name AttackComponent

@export var attributes_component: AttributesComponent
@export var base_attack_rate = 60
var attack_rate: float

func _ready():
	attack_rate = ((100 - attributes_component.speed) / 100.0) * base_attack_rate
	print("Attack Rate: " + str(attack_rate))

func attack() -> Attack:
	var attack = Attack.new()
	attack.damage = _damage_amount()
	attack.type = AttributesComponent.DamageTypes.SLASHING
	attack.crit = randi() % 100 < attributes_component.luck
	
	return attack

func _damage_amount():
	var strength = attributes_component.strength
	
	if strength >=  90:
		return randi() % 10 + 50
	if strength >=  70:
		return randi() % 10 + 40
	if strength >=  50:
		return randi() % 10 + 30
	if strength >=  30:
		return randi() % 10 + 20
	if strength >=  10:
		return randi() % 10 + 10
		
	return randi() % 10
