extends TextureRect

class_name Room

@onready var enemy_spawner: EnemySpawner = $EnemySpawner

@export var wizard_speed: int = 300
@export var max_brightness: int = 6

var is_setup : bool = false
var torches: Array[Torch]

var rng = RandomNumberGenerator.new()
var wizard_visible : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	torches = [$TorchCenter, $TorchLeft, $TorchRight]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):		
	if wizard_visible:
		var wizard_path : PathFollow2D = find_child("PathFollow2D")
		wizard_path.progress+= wizard_speed*delta
		if wizard_path.progress_ratio == 1.0:
			wizard_path.find_child("Wizard").visible = false
			wizard_visible = false

func spawn_enemy(round: int):
	enemy_spawner.spawn_enemy(round)

func setup_room(lives=3):
	_set_torches_brightness(max_brightness,lives)
	is_setup = true

func _set_torches_brightness(brightness : int, amount : int = 0):
	for torch in torches:
		torch.brightness = 0
	
	var index = 0;
	for torch in torches:
		if index >= amount:
			continue
		torch.brightness = brightness
		index += 1

func move_wizard():
	var wizard = find_child("PathFollow2D").find_child("Wizard")
	wizard.find_child("PointLight2D").set_enabled(true)
	wizard.visible = true
	wizard_visible = true
