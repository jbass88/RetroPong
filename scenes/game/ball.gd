extends CharacterBody2D

@export var base_speed: float = 400.0
@export var speed_increase: float = 25.0
# Controls how steep the bounce angle can be. 1.0 is a 45-degree angle.
# A higher value allows for steeper bounces.
@export var bounce_angle_factor: float = 1.2

@export var radius_px := 10.0
@export var spin_scale := 0.1

var v: Vector2 = Vector2(500, 0)      # your current ball velocity
var ang_vel := 0.0

var current_speed: float

func start():
	# Reset position to the center of the ball's parent (the main scene)
	position = get_parent().get_viewport_rect().size / 2
	
	current_speed = base_speed

	# Choose a random starting direction
	var direction_x = 1 if randi_range(0, 1) == 0 else -1
	var direction_y = randf_range(-0.8, 0.8)
	
	velocity = Vector2(direction_x, direction_y).normalized() * current_speed

func _physics_process(delta: float):
	var collision = move_and_collide(velocity * delta)

	if collision:
		var collider = collision.get_collider()
		
		if collider.is_in_group("paddles"):
			# 1. Get the paddle and its height. This assumes the paddle's root node
			# has a CollisionShape2D child.
			var paddle = collider
			var paddle_height = paddle.get_node("CollisionShape2D").shape.get_rect().size.y
			
			# 2. Calculate the offset from the paddle's center.
			# A positive value means the ball hit the bottom half.
			# A negative value means the ball hit the top half.
			var offset_y = self.global_position.y - paddle.global_position.y
			
			# 3. Normalize the offset to a range of -1.0 to 1.0 (or close to it)
			# This represents the new vertical direction.
			var new_y_dir = (offset_y / (paddle_height / 2.0)) * bounce_angle_factor
			
			# 4. Create the new direction vector.
			# -sign(velocity.x) inverts the horizontal direction.
			var new_direction = Vector2(-sign(velocity.x), new_y_dir)
			
			# 5. Increase the speed and apply it to the new, normalized direction
			current_speed += speed_increase
			velocity = new_direction.normalized() * current_speed
			
			if (offset_y >= -50 && offset_y <= 50):
				SoundManager.play_random_bounce(SoundManager.bounce_sounds_med.pick_random())
			else:
				SoundManager.play_random_bounce(SoundManager.bounce_sounds_high.pick_random())
		else:
			velocity = velocity.bounce(collision.get_normal())
			SoundManager.play_random_bounce(SoundManager.bounce_sounds_low.pick_random())
		
		
	# angular speed ~ linear speed / radius
	var omega = (velocity.length() / max(1.0, radius_px)) * spin_scale
	ang_vel = omega * _spin_sign(v)
	rotation = wrapf(rotation + ang_vel * delta, -PI, PI)

func _spin_sign(dir: Vector2) -> float:
	# Spin “toward” the shot: right = clockwise, left = counter-clockwise.
	# If it looks reversed in your project, flip the returned signs.
	if absf(dir.x) >= absf(dir.y):
		return 1.0 if dir.x >= 0.0 else -1.0
	else:
		return -1.0 if dir.y >= 0.0 else 1.0
