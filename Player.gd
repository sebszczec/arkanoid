extends CharacterBody2D

const ACCELERATION = 20
const MAX_SPEED = 300
const FRICTION = 100

const RIGHT_VELOCITY = Vector2(1, 0) * MAX_SPEED
const LEFT_VELOCITY = RIGHT_VELOCITY * -1

@onready var gunSprite = $GunSprite

@onready var playerSprite = $PlayerSprite
@onready var playerCollisionShape = $PlayerCollisionShape2D
@onready var playerHitBox = $PlayerHitBox

var textures = []


func _ready():
	textures.append(load("res://resources/player.png"))
	textures.append(load("res://resources/player_big.png"))


func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0:
			velocity = RIGHT_VELOCITY
		else:
			velocity = LEFT_VELOCITY
				
	else:
		velocity = Vector2.ZERO
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		if collision.get_collider().name == "Boundries":
			velocity = Vector2.ZERO


func show_gun():
	gunSprite.visible = true

	
func hide_gun():
	gunSprite.visible = false


func make_big():
	playerSprite.texture = textures[1]
	playerCollisionShape.shape.size.x = 82
	playerHitBox.get_node("CollisionShape2D").shape.size.x = 82
	
	
func make_small():
	playerSprite.texture = textures[0]
	playerCollisionShape.shape.size.x = 52
	playerHitBox.get_node("CollisionShape2D").shape.size.x = 52
	
