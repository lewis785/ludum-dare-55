extends Node2D

const ENEMY = preload("res://scenes/characters/character.tscn")

var round = 0;
@export var base_attribute_points: int = 40
@export var points_per_round: int = 10

func spawn():
	round += 1
	_spawn_enemy()

func _spawn_enemy():
	var enemy = _setup_enemy();
	add_child(enemy)

func _setup_enemy():
	var enemy = ENEMY.instantiate()
	enemy.add_to_group("enemy")
	enemy = _set_attributes(enemy)
	
	return enemy

func _set_attributes(enemy: Character):
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
		
	
	
