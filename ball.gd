extends CharacterBody2D

var ball_velocity = Vector2(-100, 200)

func _physics_process(delta):
	velocity = ball_velocity
		
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		ball_velocity = velocity.bounce(collision.get_normal())

