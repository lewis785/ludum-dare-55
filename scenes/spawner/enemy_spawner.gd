extends Node2D

class_name EnemySpawner

const ENEMY = preload("res://scenes/characters/character.tscn")

@export var base_attribute_points: int = 40
@export var points_per_round: int = 10

func spawn_enemy(round: int):
	var enemy = _setup_enemy(round);
	add_child(enemy)


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
		
	
	
