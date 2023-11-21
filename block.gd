extends CharacterBody2D

@export var MAX_HITS = 4
@export var color = "green"
var hits = 0
var textures = {}
@onready var sprite2D = $Sprite2D
@onready var animatedSprite2D = $AnimatedSprite2D

func _ready():
	var blue = []
	blue.append(load("res://resources/blocks/blue/damaged/block_d1.png"))
	blue.append(load("res://resources/blocks/blue/damaged/block_d2.png"))
	blue.append(load("res://resources/blocks/blue/damaged/block_d3.png"))
	textures["blue"] = blue
	sprite2D.texture = load("res://resources/blocks/blue/block_full.png")
	
	var red = []
	red.append(load("res://resources/blocks/red/damaged/block_d1.png"))
	red.append(load("res://resources/blocks/red/damaged/block_d2.png"))
	red.append(load("res://resources/blocks/red/damaged/block_d3.png"))
	textures["red"] = red
	sprite2D.texture = load("res://resources/blocks/red/block_full.png")
	
	var yellow = []
	yellow.append(load("res://resources/blocks/yellow/damaged/block_d1.png"))
	yellow.append(load("res://resources/blocks/yellow/damaged/block_d2.png"))
	yellow.append(load("res://resources/blocks/yellow/damaged/block_d3.png"))
	textures["yellow"] = yellow
	sprite2D.texture = load("res://resources/blocks/yellow/block_full.png")
	
	var orange = []
	orange.append(load("res://resources/blocks/orange/damaged/block_d1.png"))
	orange.append(load("res://resources/blocks/orange/damaged/block_d2.png"))
	orange.append(load("res://resources/blocks/orange/damaged/block_d3.png"))
	textures["orange"] = orange
	sprite2D.texture = load("res://resources/blocks/orange/block_full.png")
	
	var green = []
	green.append(load("res://resources/blocks/green/damaged/block_d1.png"))
	green.append(load("res://resources/blocks/green/damaged/block_d2.png"))
	green.append(load("res://resources/blocks/green/damaged/block_d3.png"))
	textures["green"] = green
	sprite2D.texture = load("res://resources/blocks/green/block_full.png")
	
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
	sprite2D.texture = textures[color][hits - 1]

func _on_animated_sprite_2d_animation_looped():
	animatedSprite2D.stop()
	animatedSprite2D.visible = false
	self.queue_free()
