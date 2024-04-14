extends Node2D
@onready var room = $".."
@onready var wizard_arm = $WizardArm
@onready var book_wizard_arm = $BookWizardArm

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_summon_book_book_up():
	#print("up")
	wizard_arm.enabled = false
	wizard_arm.visible = false
	book_wizard_arm.enabled = true
	book_wizard_arm.visible = true
	


func _on_summon_book_book_down():
	#print("down")
	wizard_arm.enabled = true
	wizard_arm.visible = true
	book_wizard_arm.enabled = false
	book_wizard_arm.visible = false

func _input(event):
	if event is InputEventMouseMotion:
		book_wizard_arm.set_position(event.position*1.44)
