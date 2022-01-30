extends Actor

func _ready() -> void:
	set_physics_process(false)
	velocity.x = -speed.x/1.5

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if is_on_wall():
		velocity.x *= -1.0
	var player_position = get_parent().get_child(1).global_position
	var enemy_position = get_node(".").global_position
	if ((enemy_position.x - player_position.x) > 800.0):
		velocity.x *= -1.0
	velocity.y = move_and_slide(velocity, Vector2.UP).y

func _on_StompDetector_body_entered(body: PhysicsBody2D):
	if body.global_position.y < get_node("StompDetector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	queue_free()
	
func _on_VisibilityEnabler2D_screen_exited():
	var player_position = get_parent().get_child(1).global_position
	var enemy_position = get_node(".").global_position
	if (player_position.x > enemy_position.x):
		get_node("CollisionShape2D").disabled = true
		queue_free()
	
