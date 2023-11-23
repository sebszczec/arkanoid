extends CharacterBody2D

@export var MAX_HITS = 4
@export var COLOR = "blue"
var hits = 0
var textures = {}
@onready var sprite2D = $Sprite2D
@onready var animatedSprite2D = $AnimatedSprite2D

func _set_color(color):
	var temp = []
	temp.append(load("res://resources/blocks/" + color + "/damaged/block_d1.png"))
	temp.append(load("res://resources/blocks/" + color + "/damaged/block_d2.png"))
	temp.append(load("res://resources/blocks/" + color + "/damaged/block_d3.png"))
	textures[color] = temp
	sprite2D.texture = load("res://resources/blocks/" + color + "/block_full.png")

	
	# more colors can be loaded if dynamic change of color will be required

func _ready():
	_set_color(COLOR)
	animatedSprite2D.visible = false

func _physics_process(delta):
	pass

func _on_hurt_box_area_entered(area):
	hits = hits + 1
	if hits == MAX_HITS:	
		sprite2D.visible = false
		animatedSprite2D.visible = true
		animatedSprite2D.play("Destroy_" + COLOR)
		return
	
	if hits >= MAX_HITS:
		return
	
	sprite2D.texture = textures[COLOR][hits - 1]

func _on_animated_sprite_2d_animation_looped():
	animatedSprite2D.stop()
	animatedSprite2D.visible = false
	self.queue_free()
