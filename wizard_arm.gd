extends CharacterBody2D
const SPEED = 200 # Set a higher speed to follow the mouse faster
@onready var wizard_arm = $"."
@onready var arm_visual = $ArmVisual

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	look_at(get_global_mouse_position())
	
func _input(_event):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		arm_visual.animation = "Thumb"
	if(not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		arm_visual.animation = "default"
