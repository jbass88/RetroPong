extends CharacterBody2D

@export var speed: float = 400.0  # Paddle speed in pixels/second

func _process(delta):
	var move := 0.0

	if GlobalData.PaddleControlRight == GlobalData.PaddleControlType.PLAYER_1:
		if Input.is_action_pressed("paddle_left_up"):
			move -= 1
		if Input.is_action_pressed("paddle_left_down"):
			move += 1
	elif GlobalData.PaddleControlRight == GlobalData.PaddleControlType.PLAYER_2:
		if Input.is_action_pressed("paddle_right_up"):
			move -= 1
		if Input.is_action_pressed("paddle_right_down"):
			move += 1

	# Move the paddle vertically
	#velocity.y += move * speed * delta
	#move_and_slide()
	position.y += move * speed * delta
	
	var screen_height = get_viewport_rect().size.y
	var paddle_height = $CollisionShape2D.shape.size.y
	position.y = clampf(position.y, paddle_height / 2, screen_height - paddle_height / 2)
