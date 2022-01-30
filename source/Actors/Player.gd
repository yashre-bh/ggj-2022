extends Actor

export var bullet_speed = 1000
var bullet = preload("res://source/Weapon/bullet.tscn")

func _process(delta):
	$gun.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("fire"):
		var bullet_instance = bullet.instance()
		bullet_instance.position = $gun/BulletPointer.get_global_position()
		bullet_instance.rotation_degrees = $gun.rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated($gun.rotation))
		get_tree().get_root().add_child(bullet_instance)
		
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
