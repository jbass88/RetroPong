extends Node2D

const SCORE_LIMIT : int = 11

@onready var score_left_label: Label = $HudLayer/ScoreLeftLabel
@onready var score_right_label: Label = $HudLayer/ScoreRightLabel

var score_left = 0
var score_right = 0

func _ready():
	# Clear the global scores when the main level loads
	GlobalData.PaddleScoreLeft = score_left
	GlobalData.PaddleScoreRight = score_right
	
	start_round()
	
func end_round():
	GlobalData.PaddleScoreLeft = score_left
	GlobalData.PaddleScoreRight = score_right
	
	SceneManager.change_scene("res://scenes/game/end_round_scene.tscn")

func start_round():
	$Ball.start()

func update_score_display():
	score_left_label.text = str(score_left)
	score_right_label.text = str(score_right)

func _on_goal_left_area_body_entered(body):
	if body.is_in_group("ball"):
		score_right += 1
		update_score_display()
		
		var score_difference = score_left - score_right		
		if (score_right >= SCORE_LIMIT || score_left >= SCORE_LIMIT) && (score_difference <= -2 || score_difference >= 2):
			end_round()
		else:
			start_round()

func _on_goal_right_area_body_entered(body):
	if body.is_in_group("ball"):
		score_left += 1
		update_score_display()
		
		var score_difference = score_left - score_right		
		if (score_right >= SCORE_LIMIT || score_left >= SCORE_LIMIT) && (score_difference <= -2 || score_difference >= 2):
			end_round()
		else:
			start_round()
			
#func reset_paddle_position(is_left: bool):
	#var screen_size = get_viewport_rect().size
	#var offset = 25.0
	#var y_pos = screen_size.y / 2 - offset
	#if is_left:
		#$PaddleLeft.position = Vector2(offset, y_pos)
	#else:
		#$PaddleRight.position = Vector2(screen_size.x - offset, y_pos)
#
#func reset_ball_position():
	#var screen_size = get_viewport_rect().size
	#$Ball.position = Vector2(screen_size.x / 2, screen_size.y / 2)
