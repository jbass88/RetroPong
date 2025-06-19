extends CharacterBody2D

# Export variables to tweak from the Inspector
@export var base_speed: float = 400.0
@export var speed_increase: float = 25.0

# This variable will hold the current speed and direction
var current_speed: float

# This function will be called from the main game to start a round
func start():
	# Reset position to the center of the ball's parent (the main scene)
	position = get_parent().get_viewport_rect().size / 2
	
	# Reset speed
	current_speed = base_speed

	# Choose a random starting direction
	var direction_x = 1 if randi_range(0, 1) == 0 else -1
	var direction_y = randf_range(-0.8, 0.8) # Add a slight vertical angle

	# Normalize the vector to ensure consistent speed, then apply speed
	velocity = Vector2(direction_x, direction_y).normalized() * current_speed

# _physics_process is the heart of the movement
func _physics_process(delta: float):
	# move_and_collide moves the body and stops on collision,
	# returning a KinematicCollision2D object with collision data.
	var collision = move_and_collide(velocity * delta)

	# If a collision occurred...
	if collision:
		# The bounce() function is perfect for this. It reflects the velocity
		# vector based on the collision's normal (the direction of the surface).
		velocity = velocity.bounce(collision.get_normal())
		
		# Check if the object we hit was a paddle
		# We'll add the paddles to a "paddles" group in the next step
		if collision.get_collider().is_in_group("paddles"):
			# Increase the speed and apply it to the velocity
			current_speed += speed_increase
			velocity = velocity.normalized() * current_speed
