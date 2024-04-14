extends Node

class_name CombatCoordinator

signal fight_started()
signal fight_win()
signal fight_lose()

@export var fighting: bool = true 
var summon: Character
var enemy: Character
var summon_last_attacked = 0
var enemy_last_attacked = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if summon == null || enemy == null:
		_waiting_for_fighters()
		fight_started.emit()
		return
	
	if fighting:
		_fight(delta)

func _waiting_for_fighters():
	summon = get_tree().get_first_node_in_group('summon')
	enemy = get_tree().get_first_node_in_group('enemy')

func _fight(delta):
	summon_last_attacked += delta
	enemy_last_attacked += delta
	
	if summon_last_attacked >= summon.attack_component.attack_rate / 100.0:
		enemy.health_component.damage(summon.attack_component.attack())
		summon_last_attacked = 0.0
		
	if enemy_last_attacked >= enemy.attack_component.attack_rate / 100.0:
		summon.health_component.damage(enemy.attack_component.attack())
		enemy_last_attacked = 0.0
