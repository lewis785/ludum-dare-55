extends Area2D

class_name SummoningCircle

@export var ingredients_cap : int = 5
@export var summon_scene : PackedScene
@onready var sprite_2d = $Sprite2D
@onready var sigil_1 = $Sigil1
@onready var sigil_2 = $Sigil2
@onready var sigil_3 = $Sigil3
@onready var sigil_4 = $Sigil4
@onready var sigil_5 = $Sigil5

@export var spawn_location : Vector2 = Vector2(250,350)
@export var summon_delay : float = 3.0 # Delay until summon spawns in
var ingredients = []

# Called when the node enters thegit c scene tree for the first time.
func _ready():
	ingredients.clear()

func is_summonable():
	if ingredients.size() > ingredients_cap or ingredients.size() == 0:
		return false
	return true

func add_ingredient(ingr):
	ingredients.append(ingr)

func remove_ingredient(ingr):
	ingredients.erase(ingr)

func combine_ingredients():
	if not is_summonable():
		return
	var stats = [0,0,0,0,0]
	
	for ingr : Ingredient in ingredients:
		stats[ingr.type] += ingr.potency
	
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

	
	var room = get_parent().get_parent().get_parent()
	# Delay to spawn Summon
	await get_tree().create_timer(summon_delay).timeout
	room.add_child(summon)
	
	summon.position = spawn_location
	
	for ingr : Ingredient in ingredients:
		#ingr.queue_free()
		ingr.visible = false

func _on_area_entered(area):
	if area.is_in_group("Ingredient"):   
		add_ingredient(area)
		sprite_2d.animation = "Active"
		sprite_2d.play()


func _on_area_exited(area):
	if area.is_in_group("Ingredient"):
		remove_ingredient(area)
		sprite_2d.animation = "Idle"
		sprite_2d.play()
		
func _on_button_pressed():
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
		
