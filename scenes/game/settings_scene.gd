extends Control

@onready var mute_button: Button = $VBoxContainer/GridContainer/MuteButton

const SPEAKER_OFF = preload("res://images/speaker-off.png")
const SPEAKER = preload("res://images/speaker.png")

func _ready() -> void:
	if SoundManager.is_muted:
		mute_button.icon = SPEAKER_OFF
	else:
		mute_button.icon = SPEAKER
	
	var master_volume = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	%MasterVolumeSlider.value = master_volume
	var music_volume = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	%MusicVolumeSlider.value = music_volume
	var sfx_volume = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sfx")))
	%SfxVolumeSlider.value = sfx_volume
	
	var window_mode = DisplayServer.window_get_mode(DisplayServer.MAIN_WINDOW_ID)
	if (window_mode == DisplayServer.WINDOW_MODE_WINDOWED ||
		window_mode == DisplayServer.WINDOW_MODE_MINIMIZED ||
		window_mode == DisplayServer.WINDOW_MODE_MAXIMIZED):
		%DisplayModeOptionButton.selected = 0
	elif window_mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		%DisplayModeOptionButton.selected = 1

func _on_back_button_pressed() -> void:
	SceneManager.remove_child_scene()

func _on_display_mode_option_button_item_selected(index: int) -> void:
	if (index == 0):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif (index == 1):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_key_binds_button_pressed() -> void:
	SceneManager.add_child_scene("res://scenes/game/key_binds_scene.tscn")

func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"),
		linear_to_db(value))

func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		linear_to_db(value))
		
func _on_mute_button_pressed() -> void:
	SoundManager.toggle_mute()
	if SoundManager.is_muted:
		mute_button.icon = SPEAKER_OFF
	else:
		mute_button.icon = SPEAKER
	
func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Sfx"),
		linear_to_db(value))
