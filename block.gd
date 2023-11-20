extends CharacterBody2D

const MAX_HITS = 4
var hits = 0

var textures = []

func _ready():
	textures.append(load("res://resources/blocks/blue/damaged/block_d1.png"))
	textures.append(load("res://resources/blocks/blue/damaged/block_d2.png"))
	textures.append(load("res://resources/blocks/blue/damaged/block_d3.png"))

func _physics_process(delta):
	pass

func _on_hurt_box_area_entered(area):
	hits = hits + 1
	if hits == 4:
		self.queue_free()
		return
	
	$Sprite2D.texture = textures[hits - 1]
