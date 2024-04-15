extends Node

class_name CombatCoordinator

signal fight_started()
signal fight_win()
signal fight_lose()

@export var allow_fighting: bool = false 
var summon: Character
var enemy: Character
var summon_last_attacked = 0
var enemy_last_attacked = 0
var fight_delay = 3.0
var fighting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if summon == null || enemy == null:
		_waiting_for_fighters()
		return
	
	if allow_fighting:
		if (!fighting):
			fight_started.emit()
			fighting = true
		_fight(delta)

func _waiting_for_fighters():
	summon = get_tree().get_first_node_in_group('summon')
	enemy = get_tree().get_first_node_in_group('enemy')

func _fight(delta):
	summon_last_attacked += delta
	enemy_last_attacked += delta
	
	if summon_last_attacked >= summon.attack_component.attack_rate / 100.0:
		enemy.health_component.damage(summon.attack_component.attack())
		if (enemy.health_component.health <= 0):
			result(Results.WIN)
		summon_last_attacked = 0.0
		
	if enemy_last_attacked >= enemy.attack_component.attack_rate / 100.0:
		summon.health_component.damage(enemy.attack_component.attack())
		if (summon.health_component.health <= 0):
			enemy.health_component.heal()
			result(Results.LOSE)
		enemy_last_attacked = 0.0

enum Results {
	WIN,
	LOSE
}

func result(result: Results):
	fighting = false
	allow_fighting = false
	match result:
		Results.WIN:
			fight_win.emit();
		Results.LOSE:
			fight_lose.emit();
	await get_tree().create_timer(fight_delay).timeout
