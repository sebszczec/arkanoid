extends CharacterBody2D

var direction = Vector2(0, 1)
@export var SPEED = 200
@export var ROTATION_SPEED = 2

signal consumed
signal destroyed

var textures = []

enum Type {Laser, Speed, Balls, Size}
var type = Type.Laser

func _init():
	textures.append(load("res://resources/laser_perk.png"))
	textures.append(load("res://resources/speed_perk.png"))
	textures.append(load("res://resources/balls_perk.png"))
	textures.append(load("res://resources/size_perk.png"))

func _physics_process(delta):
	direction = direction.normalized()
	velocity = direction * SPEED * delta
	rotate(ROTATION_SPEED * delta)
	
	var collision = move_and_collide(velocity)
	
	if direction.y < 0:
		queue_free()
	


func _on_hit_box_area_entered(area):
	consumed.emit()
	queue_free()


func _on_tree_exited():
	destroyed.emit()
	
func get_type():
	return type
	
func set_type(perkType):
	type = perkType
	$Sprite2D.texture = textures[type]
