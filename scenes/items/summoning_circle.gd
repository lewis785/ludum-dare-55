extends Area2D

class_name SummoningCircle

signal summoned()

@export var ingredients_cap : int = 5
@export var summon_scene : PackedScene
@onready var sprite_2d = $Sprite2D
@onready var sigil_1 : Sigil = $Sigil1
@onready var sigil_2 : Sigil = $Sigil2
@onready var sigil_3 : Sigil = $Sigil3
@onready var sigil_4 : Sigil = $Sigil4
@onready var sigil_5 : Sigil = $Sigil5
@onready var smoke_effect = $"../../SmokeEffect"
@onready var summoning_circle_audio = $SummoningCircleAudio

@export var spawn_location : Vector2 = Vector2(270,340)
@export var summon_delay : float = 0.75
var ingredients = []

func _ready():
	ingredients.clear()

func is_summonable():
	if ingredients.size() > ingredients_cap or ingredients.size() == 0:
		return false
	return true

func add_ingredient(ingr):
	ingredients.append(ingr)
	if sprite_2d.animation != "Active":
		sprite_2d.animation = "Active"
		sprite_2d.play()
	var stats = calculate_stats()
	show_stats(stats)

func remove_ingredient(ingr):
	ingredients.erase(ingr)
	if ingredients.size() == 0:
		sprite_2d.animation = "Idle"
		sprite_2d.play()
	else:
		var stats = calculate_stats()
		show_stats(stats)

func calculate_stats():
	var stats = [0,0,0,0,0]
	for ingr : Ingredient in ingredients:
		stats[ingr.type] += ingr.potency
	return stats

func show_stats(stats):
	update_sigil(sigil_1,stats[sigil_1.type])
	update_sigil(sigil_2,stats[sigil_2.type])
	update_sigil(sigil_3,stats[sigil_3.type])
	update_sigil(sigil_4,stats[sigil_4.type])
	update_sigil(sigil_5,stats[sigil_5.type])

func update_sigil(sigil : Sigil, level : int):
	sigil.set_brightness(level)
	sigil.update_animation(level)

func combine_ingredients():
	if not is_summonable():
		return
	
	var stats = calculate_stats()
	show_stats(stats)
	
	var summon: Character = summon_scene.instantiate() as Character
	summon.character_type = Character.CharacterTypes.SUMMON
	
	# Summon creature with new stats
	summon.position = position
	var attributes = summon.get_node("AttributesComponent")
	attributes.defence = stats[0]
	attributes.luck = stats[1]
	attributes.speed = stats[2] 
	attributes.strength = stats[3]
	attributes.vitality = stats[4]

	summon.add_to_group("summon")

	smoke_effect.position = spawn_location
	smoke_effect.animation = "default"
	var sliding_window : SlidingWindow = find_parent("SlidingWindow")
	var room : Room = sliding_window.room_instance
	# Delay to spawn Summon
	await get_tree().create_timer(summon_delay).timeout
	summoning_circle_audio.play()
	smoke_effect.visible = true
	smoke_effect.play()
	await get_tree().create_timer(1.5).timeout
	room.add_child(summon)
	
	summon.position = spawn_location

	for ingr : Ingredient in ingredients:
		# Removed in Summon Book
		ingr.visible = false

func _on_area_entered(area):
	if area.is_in_group("Ingredient"):   
		add_ingredient(area)

func _on_area_exited(area):
	if area.is_in_group("Ingredient"):
		remove_ingredient(area)

func _on_summon_button_pressed():
	combine_ingredients()

func _on_sprite_2d_animation_looped():
	if $Sprite2D.animation == "Spawn":
		$Sprite2D.animation = "Idle"
		sigil_1.visible = true
		sigil_2.visible = true
		sigil_3.visible = true
		sigil_4.visible = true
		sigil_5.visible = true
		
		sigil_1.find_child("SigilLight").energy = 2.0
		sigil_2.find_child("SigilLight").energy = 2.0
		sigil_3.find_child("SigilLight").energy = 2.0
		sigil_4.find_child("SigilLight").energy = 2.0
		sigil_5.find_child("SigilLight").energy = 2.0

func _on_smoke_effect_animation_looped():
	smoke_effect.stop()
	smoke_effect.visible = false
	var combat_coordinator : CombatCoordinator = find_parent("SlidingWindow").find_child("CombatCoordinator")
	combat_coordinator.allow_fighting = true	
