extends CharacterBody2D
const SPEED = 200 # Set a higher speed to follow the mouse faster
@onready var wizard_arm = $"."
@onready var arm_visual = $ArmVisual
@onready var cheer_1 = $Cheer1
@onready var cheer_2 = $Cheer2
@onready var cheer_3 = $Cheer3
var cheered = false
var enabled = true

var random = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	look_at(get_global_mouse_position())
	
func _input(_event):
	if (_event is InputEventMouseButton):
		if(enabled == true):
			var temp = -1
			random.randomize()
			if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
				arm_visual.animation = "Thumb"
				temp = random.randi_range(0, 2)
				match temp:
					0: 
						cheer_1.play()
					1:	
						cheer_2.play()
					2:	
						cheer_3.play()
				cheered = true
			if(not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
				arm_visual.animation = "default"
				cheered = false
