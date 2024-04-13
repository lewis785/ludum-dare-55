extends Area2D

@export_category("Properties")
@export_enum("White", "Red", "Blue", "Green", "Black") var type: int

@export_category("Components")
@export var sprite: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.frame = type
	#generate_stats()

#func generate_stats():
	#pass
