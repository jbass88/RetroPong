extends Node2D

# Link to your Ball and ScoreLabel nodes

var score_left = 0
var score_right = 0

# This function is called automatically when the game starts
func _ready():
	# Start the first round
	start_round()

func start_round():
	$Ball.start()

func update_score_display():
	$HudLayer/ScoreLeftLabel.text = str(score_left)
	$HudLayer/ScoreRightLabel.text = str(score_right)

# This function was created when you connected the signal
func _on_goal_left_area_body_entered(body):
	# Check if the body that entered was the ball
	if body.is_in_group("ball"): # We need to add the ball to a group!
		score_right += 1
		update_score_display()
		start_round()

# And the same for the right goal
func _on_goal_right_area_body_entered(body):
	if body.is_in_group("ball"):
		score_left += 1
		update_score_display()
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
