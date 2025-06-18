extends Node2D



func reset_paddle_position(is_left: bool):
	var screen_size = get_viewport_rect().size
	var offset = 25.0
	var y_pos = screen_size.y / 2 - offset
	if is_left:
		$PaddleLeft.position = Vector2(offset, y_pos)
	else:
		$PaddleRight.position = Vector2(screen_size.x - offset, y_pos)

func reset_ball_position():
	var screen_size = get_viewport_rect().size
	$Ball.position = Vector2(screen_size.x / 2, screen_size.y / 2)
