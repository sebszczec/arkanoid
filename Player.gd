extends CharacterBody2D

const ACCELERATION = 20
const MAX_SPEED = 200
const FRICTION = 100

#var player_velocity = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	# input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	var collision = move_and_collide(velocity)
	
	if collision:
		if collision.get_collider().name == "Boundries":
			velocity = Vector2.ZERO

