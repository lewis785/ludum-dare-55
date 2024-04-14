extends CharacterBody2D
@onready var area_2d = $Area2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var thrown = false
var touching = false
var attached = false
var enabled = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if(thrown == true):
		if not is_on_floor():
			velocity.y += gravity * delta
	if(attached == true):		
		velocity = Vector2(0,0)
		var direction =  area_2d.position- self.position
		velocity = direction * delta * SPEED/1.44

		move_and_slide()
	
func _input(_event):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and (touching == true)):
		print()
		attached = true
	if(not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and attached == true):
		attached = false
		thrown = true
		print("Thrown")
	
func _on_area_2d_area_entered(area):
	if(enabled == true):
		touching = true
	
func _on_area_2d_area_exited(area):
	#print("exited")
	touching = false
