extends CharacterBody2D

@export var ball: CharacterBody2D = null
@export var player_speed: float = 500.0  # Paddle speed in pixels/second
@export var ai_easy_speed: float = 200.0  # Paddle speed in pixels/second
@export var ai_medium_speed: float = 300.0  # Paddle speed in pixels/second
@export var ai_hard_speed: float = 400.0  # Paddle speed in pixels/second

var ai_timer := 0.0

func _process(delta):
	var move := 0.0

	if GlobalData.PaddleControlRight == GlobalData.PaddleControlType.PLAYER_1:
		if Input.is_action_pressed("paddle_left_up"):
			move -= 1
		if Input.is_action_pressed("paddle_left_down"):
			move += 1
		position.y += move * player_speed * delta
	elif GlobalData.PaddleControlRight == GlobalData.PaddleControlType.PLAYER_2:
		if Input.is_action_pressed("paddle_right_up"):
			move -= 1
		if Input.is_action_pressed("paddle_right_down"):
			move += 1
		position.y += move * player_speed * delta
	elif GlobalData.PaddleControlRight == GlobalData.PaddleControlType.AI_EASY:
		var target_y = ball.position.y + randf_range(-32, 32)
		if position.y < target_y - 5:
			move = 1
		elif position.y > target_y + 5:
			move = -1
		position.y += move * ai_easy_speed * delta
	elif GlobalData.PaddleControlRight == GlobalData.PaddleControlType.AI_MEDIUM:
		var target_y = ball.position.y + randf_range(-10, 10)
		if position.y < target_y - 2:
			move = 1
		elif position.y > target_y + 2:
			move = -1
		position.y += move * ai_medium_speed * delta
	elif GlobalData.PaddleControlRight == GlobalData.PaddleControlType.AI_HARD:
		var target_y = ball.position.y
		if position.y < target_y - 1:
			move = 1
		elif position.y > target_y + 1:
			move = -1
		position.y += move * ai_hard_speed * delta
	
	var screen_height = get_viewport_rect().size.y
	var paddle_height = $CollisionShape2D.shape.size.y
	position.y = clampf(position.y, paddle_height / 2, screen_height - paddle_height / 2)
