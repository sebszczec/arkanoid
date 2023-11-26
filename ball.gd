extends CharacterBody2D

@onready var audioPlayer = $BounceSoundPlayer
var direction = Vector2(0, 1)
@export var SPEED = 200
var redTexture = null

signal collided

func _init():
	redTexture = load("res://resources/ball_red.png")
	
	var generator = RandomNumberGenerator.new()
	var random_x_direction = generator.randf_range(-1, 1)
	direction.x = random_x_direction

func _ready():
	pass

func _physics_process(delta):
	direction = direction.normalized()
	velocity = direction * SPEED * delta
	
	var collision = move_and_collide(velocity)
	
	if collision != null:
		direction = direction.bounce(collision.get_normal())
		audioPlayer.play()
		
		collided.emit(velocity.length())


func turn_red():
	$Sprite2D.texture = redTexture
	
