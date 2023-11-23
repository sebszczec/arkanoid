extends CharacterBody2D

var direction = Vector2(0, -1)
@export var SPEED = 200

func _physics_process(delta):
	direction = direction.normalized()
	velocity = direction * SPEED * delta
	
	var collision = move_and_collide(velocity)
	


func _on_hit_box_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	queue_free()
