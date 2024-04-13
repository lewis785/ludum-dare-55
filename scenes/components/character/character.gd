extends Node2D

class_name Character

@export var cb: CharacterBody2D

@onready var attributes_component : AttributesComponent = $AttributesComponent
@onready var health_component : HealthComponent = $HealthComponent

