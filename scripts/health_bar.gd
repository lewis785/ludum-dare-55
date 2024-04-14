extends ProgressBar

@export var health_component: HealthComponent
@onready var animated_sprite_2d = $"../AnimatedSprite2D"

func _ready():
	value = health_component.max_health
	max_value = health_component.max_health
	print("HEALTH POS: " + str(animated_sprite_2d.position.y))
	
	

func _on_health_component_damaged(damage, crit):
	value -= damage
