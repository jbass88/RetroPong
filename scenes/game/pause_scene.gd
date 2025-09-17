extends Control


func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	SceneManager.remove_child_scene()

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	SceneManager.remove_child_scene()
	SceneManager.change_scene("res://scenes/game/main_level_scene.tscn")

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	SceneManager.remove_child_scene()
	SceneManager.load_main_menu()

func _on_settings_button_pressed() -> void:
	SceneManager.add_child_scene("res://scenes/game/settings_scene.tscn")
