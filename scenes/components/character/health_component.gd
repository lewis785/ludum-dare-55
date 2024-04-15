extends Node

class_name HealthComponent

const FLOATING_LABEL = preload("res://scenes/ui/floating_label.tscn")

signal damaged(damage: int, crit: bool)
signal died()
signal healed(heal: int)

@export var attributes: AttributesComponent
@export var base_health: float = 0.0;
@export var vitality_modifier: float = 100.0
@export var enable_regen: bool = true
@export var regen_per_vitality: float = 0.1

var max_health: float
var health: float = 0.0
var regen_per_second = 0

func _ready():
	max_health = base_health + (vitality_modifier * attributes.vitality)
	health = max_health
	
var regen_timer = 0.0
func _process(delta):
	if (!enable_regen):
		return
		
	regen_timer += delta
	if regen_timer > 1.0:
		_regen()
		regen_timer = 0.0

func damage(value: Attack):
	var damage = _calculate_damage(value)
	health -= damage
	
	damaged.emit(damage, value.crit)

	if health <= 0:
		died.emit()

func heal(amount: int):
	healed.emit(amount)
	health = min(health + amount, max_health)	
	
func full_heal():
	heal(max_health - health)

func _regen():
	var variability = randf_range(0.90, 1.10)
	var max_regen = round(max_health * (attributes.vitality * regen_per_vitality / 100.0) * variability)
	
	if max_regen > 0:
		heal(min(max_regen, max_health - health))

func _calculate_damage(attack: Attack):
	var defence: float = (100 - attributes.defence) / 100.0; 
	var resistance: float = (100 - attributes.get_resistance_value(attack.type)) / 100.0
	var damage = attack.damage
	var crit_modifier = damage if attack.crit else 0
	
	return round((damage * defence * resistance) + crit_modifier)
	
