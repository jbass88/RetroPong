extends Control

const PADDLE_TYPE = "PADDLE_TYPE"

@export var button_group_left: ButtonGroup 
@export var button_group_right: ButtonGroup 

@onready var check_button_left_player_1: CheckButton = $MarginContainer/VBoxContainer/CenterContainer/GridContainer/CheckButtonLeftPlayer1
@onready var check_button_left_player_2: CheckButton = $MarginContainer/VBoxContainer/CenterContainer/GridContainer/CheckButtonLeftPlayer2
@onready var check_button_left_ai_easy: CheckButton = $MarginContainer/VBoxContainer/CenterContainer/GridContainer/CheckButtonLeftAiEasy
@onready var check_button_left_ai_medium: CheckButton = $MarginContainer/VBoxContainer/CenterContainer/GridContainer/CheckButtonLeftAiMedium
@onready var check_button_left_ai_hard: CheckButton = $MarginContainer/VBoxContainer/CenterContainer/GridContainer/CheckButtonLeftAiHard
@onready var check_button_right_player_1: CheckButton = $MarginContainer/VBoxContainer/CenterContainer/GridContainer/CheckButtonRightPlayer1
@onready var check_button_right_player_2: CheckButton = $MarginContainer/VBoxContainer/CenterContainer/GridContainer/CheckButtonRightPlayer2
@onready var check_button_right_ai_easy: CheckButton = $MarginContainer/VBoxContainer/CenterContainer/GridContainer/CheckButtonRightAiEasy
@onready var check_button_right_ai_medium: CheckButton = $MarginContainer/VBoxContainer/CenterContainer/GridContainer/CheckButtonRightAiMedium
@onready var check_button_right_ai_hard: CheckButton = $MarginContainer/VBoxContainer/CenterContainer/GridContainer/CheckButtonRightAiHard


func _ready():
	GlobalData.PaddleControlLeft = GlobalData.PaddleControlType.NONE
	GlobalData.PaddleControlRight = GlobalData.PaddleControlType.NONE
	
	check_button_left_player_1.set_meta(PADDLE_TYPE, GlobalData.PaddleControlType.PLAYER_1)
	check_button_left_player_2.set_meta(PADDLE_TYPE, GlobalData.PaddleControlType.PLAYER_2)
	check_button_left_ai_easy.set_meta(PADDLE_TYPE, GlobalData.PaddleControlType.AI_EASY)
	check_button_left_ai_medium.set_meta(PADDLE_TYPE, GlobalData.PaddleControlType.AI_MEDIUM)
	check_button_left_ai_hard.set_meta(PADDLE_TYPE, GlobalData.PaddleControlType.AI_HARD)
	
	check_button_right_player_1.set_meta(PADDLE_TYPE, GlobalData.PaddleControlType.PLAYER_1)
	check_button_right_player_2.set_meta(PADDLE_TYPE, GlobalData.PaddleControlType.PLAYER_2)
	check_button_right_ai_easy.set_meta(PADDLE_TYPE, GlobalData.PaddleControlType.AI_EASY)
	check_button_right_ai_medium.set_meta(PADDLE_TYPE, GlobalData.PaddleControlType.AI_MEDIUM)
	check_button_right_ai_hard.set_meta(PADDLE_TYPE, GlobalData.PaddleControlType.AI_HARD)

func _on_button_cancel_pressed() -> void:
	SceneManager.load_main_menu()

func _on_button_start_pressed() -> void:
	var left_pressed_button = button_group_left.get_pressed_button()
	var right_pressed_button = button_group_right.get_pressed_button()
	
	var left_paddle_type : GlobalData.PaddleControlType = GlobalData.PaddleControlType.NONE
	var right_paddle_type : GlobalData.PaddleControlType = GlobalData.PaddleControlType.NONE
	
	if left_pressed_button:
		left_paddle_type = left_pressed_button.get_meta(PADDLE_TYPE)
	if right_pressed_button:
		right_paddle_type = right_pressed_button.get_meta(PADDLE_TYPE)
	
	if left_paddle_type == GlobalData.PaddleControlType.NONE:
		SceneManager.show_error_message("Select Player (1/2) or AI (Easy, Medium, or Hard) for the left paddle.")
	elif right_paddle_type == GlobalData.PaddleControlType.NONE:
		SceneManager.show_error_message("Select Player (1/2) or AI (Easy, Medium, or Hard) for the right paddle.")
	else:
		GlobalData.PaddleControlLeft = left_paddle_type
		GlobalData.PaddleControlRight = right_paddle_type
		SceneManager.change_scene("res://scenes/game/main_level_scene.tscn")
