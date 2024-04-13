extends Node2D

var amount = 0

@onready var label = $Label

var velocity: Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Label created")
	label.set_text(str(amount))
	
	var tween = create_tween()
	velocity = Vector2(0, 100)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2)
	tween.tween_property(self, "scale", Vector2(0.1, 0.1), 0.7).set_delay(0.1)
	tween.connect("finished", on_tween_finished)
	
func on_tween_finished():
	self.queue_free()

func _process(delta):
	position -= velocity * delta
