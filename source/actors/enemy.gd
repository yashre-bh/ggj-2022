extends "res://source/actors/actor.gd"

func _ready():
	set_physics_process(false)
	velocity.x = -speed.x

func _physics_process(delta : float) -> void:
	velocity.y += gravity * delta
	if is_on_wall():
		velocity.x *= -1.0
		
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y
