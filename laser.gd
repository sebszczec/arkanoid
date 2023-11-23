extends CharacterBody2D

@onready var shoot_player = $LaserShootPlayer
var direction = Vector2(0, -1)
@export var SPEED = 200

signal laser_destroyed

func _ready():
	shoot_player.play()

func _physics_process(delta):
	direction = direction.normalized()
	velocity = direction * SPEED * delta
	
	var collision = move_and_collide(velocity)
	
	if position.y < 0:
		queue_free()
	

func _on_hit_box_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	queue_free()


func _on_tree_exited():
	laser_destroyed.emit()
