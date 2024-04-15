extends AnimatedSprite2D
class_name Sigil
#@export var brightness: float
@export var type: int

#@export var pulseDelay: int
#@export var statNumber: int
#@export var statValue: int
#@export var midThreshold: int
#@export var highThreshold: int

#var counter = 0

func set_brightness(brightness):
	find_child("SigilLight").energy = brightness

func update_animation(level):
	match type:
		0: # Defence
			if level < 30:
				animation = "Defence1"
			elif level < 60:
				animation = "Defence2"
			else:
				animation = "Defence3"
		1: # Luck
			if level < 30:
				animation = "Luck1"
			elif level < 60:
				animation = "Luck2"
			else:
				animation = "Luck3"
		2: # Speed
			if level < 30:
				animation = "Speed1"
			elif level < 60:
				animation = "Speed2"
			else:
				animation = "Speed3"
		3: # Strength
			if level < 30:
				animation = "Strength1"
			elif level < 60:
				animation = "Strength2"
			else:
				animation = "Strength3"
		4: # Vitality
			if level < 30:
				animation = "Vitality1"
			elif level < 60:
				animation = "Vitality2"
			else:
				animation = "Vitality3"

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#counter+=1
