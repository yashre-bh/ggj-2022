extends Actor

func _physics_process(delta: float) -> void:
	var is_jumping: = Input.is_action_just_pressed("jump") and velocity.y < 0.0
	var direction := get_direction()
	velocity = get_velocity(velocity,direction,speed, is_jumping)
	velocity = move_and_slide(velocity, Vector2.UP)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)
	
func get_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jumping: bool
	) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	return new_velocity



func _on_EnemyDetector_area_entered(area):
	pass # Replace with function body.
