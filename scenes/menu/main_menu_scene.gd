extends Control

func _on_start_button_pressed() -> void:
	SceneManager.change_scene("res://scenes/game/control_scene.tscn")

func _on_settings_button_pressed() -> void:
	SceneManager.show_error_message("Feature not implemented yet.")

func _on_exit_button_pressed() -> void:
	get_tree().quit(0)
