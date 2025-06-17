extends Control

func _on_start_button_pressed() -> void:
	Functions.add_child_scene("res://scenes/game/test_scene.tscn")

func _on_settings_button_pressed() -> void:
	Functions.show_error_message("Feature not implemented yet.")

func _on_exit_button_pressed() -> void:
	get_tree().quit(0)
