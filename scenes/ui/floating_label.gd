extends Node2D

var amount = 0

@onready var label: Label = $Label

var velocity: Vector2 = Vector2(0,0)
var max_size: Vector2 = Vector2(1,1)
var type: Types = Types.DAMAGE

enum Types {
	DAMAGE,
	CRITICAL,
	HEAL
}

# Called when the node enters the scene tree for the first time.
func _ready():
	label.set_text(str(amount))
	setup()
	movement()
	animation()

func _process(delta):
	position -= velocity * delta
	
func setup():
	match type:
		Types.DAMAGE:
			label.add_theme_color_override("font_color", Color(0.804, 0.031, 0.027))
			max_size = Vector2(1,1)
		Types.CRITICAL:
			label.add_theme_color_override("font_color", Color.GOLD)
			max_size = Vector2(2,2)
		Types.HEAL:
			label.add_theme_color_override("font_color", Color.FOREST_GREEN)
			max_size = Vector2(1.5, 1.5)

func movement():
	var x_velocity = randi() % 60 - 30
	velocity = Vector2(x_velocity, 100)

func animation():	
	var tween = create_tween()
	tween.tween_property(self, "scale", max_size, 0.2)
	tween.tween_property(self, "scale", Vector2(0.1, 0.1), 0.7).set_delay(0.1)
	tween.connect("finished", on_tween_finished)

func on_tween_finished():
	self.queue_free()


