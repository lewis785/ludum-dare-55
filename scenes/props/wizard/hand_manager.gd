extends Node2D

@onready var wizard_arm = $WizardArm

@export var book_wizard_arm_scene = preload("res://scenes/props/wizard/book_wizard_arm.tscn")
var book_wizard

# Called when the node enters the scene tree for the first time.
func _ready():
	var sliding_window : SlidingWindow = find_parent("SlidingWindow")
	var combat_coordinator : CombatCoordinator = sliding_window.find_child("CombatCoordinator")
	combat_coordinator.connect("fight_win", Callable(self, "_on_combat_coordinator_fight_win"))
	combat_coordinator.connect("fight_started", Callable(self, "_on_combat_coordinator_fight_started"))
	
	var summon_book = sliding_window.find_child("SummonBook")
	book_wizard = summon_book.find_parent("Overlay").find_child("BookWizardArm") # Get Book Wizard from Overlay
	summon_book.connect("book_up", Callable(self, "_on_summon_book_book_up"))
	summon_book.connect("book_down", Callable(self, "_on_summon_book_book_down"))
	

func _on_summon_book_book_up():
	wizard_arm.enabled = false
	wizard_arm.visible = false
	book_wizard.enabled = true
	book_wizard.visible = true

func _on_summon_book_book_down():
	wizard_arm.enabled = true
	wizard_arm.visible = true
	book_wizard.enabled = false
	book_wizard.visible = false

func _on_combat_coordinator_fight_started():
	wizard_arm.enabled = true
	wizard_arm.visible = true
	book_wizard.enabled = false
	book_wizard.visible = false
	
func _on_combat_coordinator_fight_win():
	wizard_arm.enabled = false
	wizard_arm.visible = false
	book_wizard.enabled = false
	book_wizard.visible = false
