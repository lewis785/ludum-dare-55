extends Label

@export
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _on_ingredient_mouse_entered():
	visible = true

func _on_ingredient_mouse_exited():
	visible = false
