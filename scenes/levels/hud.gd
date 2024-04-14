extends CanvasLayer
var music_muted = false
var fx_muted = false
@onready var music_mute_button = $MusicMuteButton
@onready var fx_mute_button = $FXMuteButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func is_left_click(event):
	if (!event is InputEventMouseButton || !event.pressed):
		return false
	return event.button_index == MOUSE_BUTTON_LEFT
	
func _on_music_mute_button_gui_input(event):
	if is_left_click(event):
		music_muted = !music_muted
		set_music_muted(music_muted)


func _on_fx_mute_button_gui_input(event):
	if is_left_click(event):
		fx_muted = !fx_muted
		set_fx_muted(fx_muted)

func set_music_muted(is_muted):
	if(is_muted):
		music_mute_button.texture = load("res://assets/elements/musictempNOT.png")
	else:
				music_mute_button.texture = load("res://assets/elements/musictemp.png")
#	config.save_value("sound", "music_muted", is_muted)
	AudioServer.set_bus_mute(2, is_muted)

func set_fx_muted(is_muted):
	if(is_muted):
		fx_mute_button.texture = load("res://assets/elements/fxtempNOT.png")
	else:
				fx_mute_button.texture = load("res://assets/elements/fxtemp.png")
#	config.save_value("sound", "fx_muted", is_muted)
	AudioServer.set_bus_mute(1, is_muted)
