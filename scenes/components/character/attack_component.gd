extends Node

class_name AttackComponent

@export var attributes_component: AttributesComponent
@export var base_attack_rate = 60
@export var sprit: AnimatedSprite2D

@onready var blunt_1 = $Blunt1
@onready var blunt_2 = $Blunt2
@onready var blunt_3 = $Blunt3
@onready var blade_1 = $Blade1
@onready var blade_2 = $Blade2
@onready var blade_3 = $Blade3

enum AttackDirection { LEFT, RIGHT}
@export var attack_direction: AttackDirection = AttackDirection.RIGHT
var attack_rate: float

func _ready():
	attack_rate = ((100 - attributes_component.speed) / 100.0) * base_attack_rate

func attack() -> Attack:
	var attack = Attack.new()
	attack.damage = _damage_amount()
	attack.type = AttributesComponent.DamageTypes.SLASHING
	attack.crit = randi() % 100 < attributes_component.luck
	var random = RandomNumberGenerator.new()
	var temp = -1
	random.randomize()
	_attack_movement()
	temp = random.randi_range(0, 15)
	match temp:
		0: 
			blunt_1.play()
		1:	
			blunt_2.play()
		2:	
			blunt_3.play()
		4: 
			blade_1.play()
		5:	
			blade_2.play()
		6:	
			blade_3.play()	
	return attack

func _attack_movement():
	var attack_vector = Vector2(20, 0) if attack_direction == AttackDirection.RIGHT else Vector2(-20, 0)
	var tween = create_tween()
	
	tween.tween_property(sprit, "position", attack_vector, 0.05)
	tween.tween_property(sprit, "position", Vector2(0, 0), 0.05)

func _damage_amount():
	var strength = attributes_component.strength
	
	if strength >=  90:
		return randi() % 100 + 500
	if strength >=  70:
		return randi() % 100 + 400
	if strength >=  50:
		return randi() % 100 + 300
	if strength >=  30:
		return randi() % 100 + 200
	if strength >=  10:
		return randi() % 100 + 100
		
	return randi() % 100
