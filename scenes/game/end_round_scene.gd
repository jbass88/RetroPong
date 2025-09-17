extends Control

@onready var label_header_result: Label = $VBoxContainer/MarginContainer2/LabelHeaderResult
@onready var label_score_left: Label = $VBoxContainer/CenterContainer/GridContainer/LabelScoreLeft
@onready var label_score_right: Label = $VBoxContainer/CenterContainer/GridContainer/LabelScoreRight
@onready var label_score_left_value: Label = $VBoxContainer/CenterContainer/GridContainer/LabelScoreLeftValue
@onready var label_score_right_value: Label = $VBoxContainer/CenterContainer/GridContainer/LabelScoreRightValue

func _ready():
	label_score_left.text = StringManager.format_paddle_control_type(GlobalData.PaddleControlLeft)
	label_score_left_value.text = str(GlobalData.PaddleScoreLeft)
	label_score_right.text = StringManager.format_paddle_control_type(GlobalData.PaddleControlRight)
	label_score_right_value.text = str(GlobalData.PaddleScoreRight)
	
	if GlobalData.PaddleScoreLeft > GlobalData.PaddleScoreRight:
		label_header_result.text = StringManager.format_paddle_control_type(GlobalData.PaddleControlLeft) + " Wins!"
	else:
		label_header_result.text = StringManager.format_paddle_control_type(GlobalData.PaddleControlRight) + " Wins!"

func _on_button_restart_keep_pressed() -> void:
	SceneManager.change_scene("res://scenes/game/main_level_scene.tscn")

func _on_button_credits_pressed() -> void:
	SceneManager.change_scene("res://scenes/game/credits_scene.tscn")

func _on_button_main_menu_pressed() -> void:
	SceneManager.load_main_menu()
