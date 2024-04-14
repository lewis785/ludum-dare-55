extends Node2D

@onready var wizard_arm = $WizardArm
@onready var book_wizard_arm = $BookWizardArm

# Called when the node enters the scene tree for the first time.
func _ready():
	var summon_book = get_parent().get_parent().find_child("SummonBook")
	summon_book.connect("book_up", Callable(self, "_on_summon_book_book_up"))
	summon_book.connect("book_down", Callable(self, "_on_summon_book_book_down"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_summon_book_book_up():
	print("up")
	wizard_arm.enabled = false
	wizard_arm.visible = false
	book_wizard_arm.enabled = true
	book_wizard_arm.visible = true

func _on_summon_book_book_down():
	print("down")
	wizard_arm.enabled = true
	wizard_arm.visible = true
	book_wizard_arm.enabled = false
	book_wizard_arm.visible = false
