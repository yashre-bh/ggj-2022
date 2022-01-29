extends Actor


func _physics_process(delta : float) -> void:
	#var is_jump_interrupted: = true if (Input.action_just_released("jump") and velocity.y < 0.0) else false
	var direction := get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed)
	velocity = move_and_slide(velocity,FLOOR_NORMAL)
	
func get_direction() -> Vector2:
	return Vector2(
	Input.get_action_strength("move right") - Input.get_action_strength("move left"),
	Input.get_action_strength("jump") if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
)

func calculate_move_velocity(
	linear_velocity: Vector2,
	speed: Vector2,
	direction: Vector2
	#is_jump_interrupted: bool
	) -> Vector2:
		var new_velocity: = linear_velocity
		new_velocity.x = speed.x * direction.x
		new_velocity.y += gravity * get_physics_process_delta_time()
		if direction.y == 1.0:
			new_velocity.y = speed.y * direction.y
			
		return new_velocity
