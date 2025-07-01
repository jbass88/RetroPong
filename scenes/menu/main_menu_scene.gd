extends Control

@onready var mute_button: Button = $VBoxContainer/MarginContainer/MuteButton


const SPEAKER_OFF = preload("res://images/speaker-off.png")
const SPEAKER = preload("res://images/speaker.png")

func _ready() -> void:
	SoundManager.play_background_music()

func _on_start_button_pressed() -> void:
	SceneManager.change_scene("res://scenes/game/control_scene.tscn")

func _on_settings_button_pressed() -> void:
	SceneManager.show_error_message("Feature not implemented yet.")

func _on_exit_button_pressed() -> void:
	get_tree().quit(0)

func _on_mute_button_pressed() -> void:
	SoundManager.toggle_mute()
	if SoundManager.is_muted:
		mute_button.icon = SPEAKER_OFF
	else:
		mute_button.icon = SPEAKER
