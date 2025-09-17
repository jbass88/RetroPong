extends Control


func _ready() -> void:
	var master_volume = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	%MasterVolumeSlider.value = master_volume
	var music_volume = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	%MusicVolumeSlider.value = music_volume
	var sfx_volume = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sfx")))
	%SfxVolumeSlider.value = sfx_volume
	
	var window_mode = DisplayServer.window_get_mode(DisplayServer.MAIN_WINDOW_ID)
	if window_mode == DisplayServer.WINDOW_MODE_WINDOWED:
		%DisplayModeOptionButton.selected = 0
	elif window_mode == DisplayServer.WINDOW_MODE_WINDOWED:
		%DisplayModeOptionButton.selected = 1
	

func _on_back_button_pressed() -> void:
	SceneManager.remove_child_scene()

func _on_display_mode_option_button_item_selected(index: int) -> void:
	if (index == 0):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif (index == 1):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_key_binds_button_pressed() -> void:
	# TODO: 
	pass # Replace with function body.

func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"),
		linear_to_db(value))

func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		linear_to_db(value))
	
func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Sfx"),
		linear_to_db(value))
