extends Control

@onready var mute_button: Button = $VBoxContainer/MarginContainer/MuteButton

const SPEAKER_OFF = preload("res://images/speaker-off.png")
const SPEAKER = preload("res://images/speaker.png")

func _ready() -> void:
	if SoundManager.first_load:
		SoundManager.first_load = false
		SoundManager.mute_all()
		
	if SoundManager.is_muted:
		mute_button.icon = SPEAKER_OFF
	else:
		mute_button.icon = SPEAKER
	SoundManager.play_background_music()

func _on_start_button_pressed() -> void:
	SceneManager.change_scene("res://scenes/game/control_scene.tscn")

func _on_settings_button_pressed() -> void:
	SceneManager.add_child_scene("res://scenes/game/settings_scene.tscn")

func _on_mute_button_pressed() -> void:
	SoundManager.toggle_mute()
	if SoundManager.is_muted:
		mute_button.icon = SPEAKER_OFF
	else:
		mute_button.icon = SPEAKER

func _on_credits_button_pressed() -> void:
	SceneManager.change_scene("res://scenes/game/credits_scene.tscn")
