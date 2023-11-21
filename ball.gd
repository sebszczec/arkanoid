extends CharacterBody2D

var generator = RandomNumberGenerator.new()
var random_x_direction = generator.randf_range(-100, 100)
var ball_velocity = Vector2(random_x_direction, 200)

func _physics_process(delta):
	velocity = ball_velocity
		
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		ball_velocity = velocity.bounce(collision.get_normal()) + (0.25 * collision.get_collider_velocity())
		


