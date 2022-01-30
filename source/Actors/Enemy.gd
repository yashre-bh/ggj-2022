extends Actor

var health: = 100.0

func _ready() -> void:
	set_physics_process(false)
	velocity.x = -speed.x

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if is_on_wall():
		velocity.x *= -1.0
	velocity.y = move_and_slide(velocity, Vector2.UP).y


func _on_StompDetector_body_entered(body: PhysicsBody2D):
	if body.global_position.y < get_node("StompDetector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	queue_free()

func _on_BulletDetector_body_entered(body: PhysicsBody2D):
	if body.global_position.y < get_node("BulletDetector").global_position.y:
		return
	print_debug("hitttt")
	health -= 25.0
	if(health == 0.0):
		get_node("CollisionShape2D").disabled = true
		queue_free()
