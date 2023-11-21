extends CharacterBody2D

@export var MAX_HITS = 4
var hits = 0
var textures = []
@onready var sprite2D = $Sprite2D
@onready var animatedSprite2D = $AnimatedSprite2D

func _ready():
	textures.append(load("res://resources/blocks/blue/damaged/block_d1.png"))
	textures.append(load("res://resources/blocks/blue/damaged/block_d2.png"))
	textures.append(load("res://resources/blocks/blue/damaged/block_d3.png"))
	
	animatedSprite2D.visible = false

func _physics_process(delta):
	pass

func _on_hurt_box_area_entered(area):
	hits = hits + 1
	if hits == MAX_HITS:	
		sprite2D.visible = false
		animatedSprite2D.visible = true
		animatedSprite2D.play("Destroy")
		return
	
	assert(hits < 4)
	sprite2D.texture = textures[hits - 1]

func _on_animated_sprite_2d_animation_looped():
	animatedSprite2D.stop()
	animatedSprite2D.visible = false
	self.queue_free()
