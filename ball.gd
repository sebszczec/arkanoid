extends CharacterBody2D

var player_velocity = Vector2(-100, 200)

func _physics_process(delta):
	velocity = player_velocity
		
	var collision = move_and_collide(velocity * delta)
	
	if collision:
			player_velocity = velocity.bounce(collision.get_normal())
	
