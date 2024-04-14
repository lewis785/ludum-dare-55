extends ProgressBar

@export var health_component: HealthComponent

func _ready():
	max_value = health_component.max_health
	value = max_value

func _on_health_component_damaged(damage, crit):
	value -= damage


func _on_health_component_healed(heal):
	value += heal
