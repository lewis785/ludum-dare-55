extends AnimatedSprite2D
@export var brightness: float
@export var pulseDelay: int
@export var statNumber: int
@export var statValue: int
@export var midThreshold: int
@export var highThreshold: int

var counter = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter+=1
