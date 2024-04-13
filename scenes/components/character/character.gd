extends Node2D

class_name Character

@export var character_body: CharacterBody2D

@onready var attack_component: AttackComponent = $AttackComponent
@onready var attributes_component : AttributesComponent = $AttributesComponent
@onready var health_component : HealthComponent = $HealthComponent
