extends Node2D

class_name Character

@export var character_type: CharacterTypes

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var attack_component: AttackComponent = $AttackComponent
@onready var attributes_component : AttributesComponent = $AttributesComponent
@onready var health_component : HealthComponent = $HealthComponent

enum CharacterTypes {
	ENEMY,
	SUMMON
}

const FLOATING_LABEL = preload("res://scenes/ui/floating_label.tscn")

func _ready():
	if character_type == CharacterTypes.ENEMY:
		pick_enemy_sprite()
		attack_component.attack_direction = attack_component.AttackDirection.LEFT
	else:
		animated_sprite_2d.animation = "summon"


func _on_health_component_damaged(damage: int, crit: bool):
	var text = FLOATING_LABEL.instantiate()
	text.amount = damage
	text.position.x = 50
	if crit:
		text.type = text.Types.CRITICAL

	add_child(text)

func _on_health_component_healed(heal):
	var text = FLOATING_LABEL.instantiate()
	text.amount = heal
	text.position.x = 50
	text.type = text.Types.HEAL
	
	add_child(text)
	pass # Replace with function body.


func pick_enemy_sprite():
	var stats = ["defence", "health", "luck", "speed", "strength"]
	var random_index = randi() % len(stats)
	animated_sprite_2d.animation = "enemy"
	animated_sprite_2d.set_frame_and_progress(random_index, 0.0)
