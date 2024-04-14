extends Node2D

class_name EnemySpawner

const ENEMY = preload("res://scenes/characters/character.tscn")

@export var base_attribute_points: int = 40
@export var points_per_round: int = 10
@export var enemy_strengths: EnemyStrengths

func spawn_enemy(round: int):
	var enemy = _setup_enemy(round);
	add_child(enemy)
	_set_enemy_strengths(enemy)

func _setup_enemy(round: int):
	var enemy = ENEMY.instantiate()
	enemy.add_to_group("enemy")
	return _set_attributes(enemy, round)

func _set_attributes(enemy: Character, round: int):
	var attribute_points = base_attribute_points + (round * points_per_round)
	var attributes = enemy.get_node("AttributesComponent") as AttributesComponent
	
	attributes.vitality = (round * points_per_round)
	for attribute: AttributesComponent.Attributes in attributes.Attributes.values():
		if attribute == AttributesComponent.Attributes.VITALITY:
			continue
		var value = randi() % (attribute_points + 1)
		attribute_points -= value
		attributes.set_attribute_value(attribute, value)
		
	return enemy
		
func _set_enemy_strengths(enemy: Character):
	if !(enemy_strengths is EnemyStrengths):
		return

	var strengths = _get_strongest_stats(enemy)
	enemy_strengths.primary = strengths[0]
	enemy_strengths.secondary = strengths[1]
	
func _get_strongest_stats(enemy: Character):
	var attributes = enemy.attributes_component.get_attributes()
	var primary = AttributesComponent.Attributes.DEFENCE
	var secondary
	
	for key in attributes.keys():
		if key == AttributesComponent.Attributes.VITALITY:
			continue
			
		if (attributes[key] > attributes[primary]):
			secondary = primary
			primary = key
		elif (key != primary && (secondary == null || attributes[key] > attributes[secondary])):
			secondary = key
			
	return [primary, secondary]
	
