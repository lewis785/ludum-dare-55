extends CharacterBody2D
const SPEED = 200 # Set a higher speed to follow the mouse faster
@onready var wizard_arm = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	look_at(get_global_mouse_position())
