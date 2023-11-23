extends CharacterBody2D


@onready var audioPlayer = $AudioStreamPlayer
var direction = Vector2(0, 1)
@export var SPEED = 200

func _ready():
	var generator = RandomNumberGenerator.new()
	var random_x_direction = generator.randf_range(-1, 11)
	direction.x = random_x_direction

func _physics_process(delta):
	direction = direction.normalized()
	velocity = direction * SPEED * delta
	
	var collision = move_and_collide(velocity)
	
	if collision != null:
		direction = direction.bounce(collision.get_normal())
		audioPlayer.play()
