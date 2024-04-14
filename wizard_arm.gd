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
	#velocity = Vector2(0,0)
	#var direction = get_viewport().get_mouse_position() - wizard_arm.position
	#velocity = direction * delta * SPEED
	#wizard_arm.rotate()
	look_at(get_global_mouse_position())
