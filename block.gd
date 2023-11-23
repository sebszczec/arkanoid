extends CharacterBody2D

@export var MAX_HITS = 4
@export var COLOR = "blue"
@export var CAN_PRODUCE_PERK = true
@export var PERK_CHANCE = 1
var hits = 0
var textures = {}
var random = RandomNumberGenerator.new()
@onready var sprite2D = $Sprite2D
@onready var animatedSprite2D = $AnimatedSprite2D
@onready var crackSoundPlayer = $CrackSoundPlayer
@onready var destroySoundPlayer = $DestroySoundPlayer

signal create_perk

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
	var logic_handler = get_tree().root.get_child(0).get_node("LogicHandler")
	connect("create_perk", logic_handler._on_block_create_perk)

func _physics_process(delta):
	pass

func _on_hurt_box_area_entered(area):
	hits = hits + 1
	if hits == MAX_HITS:	
		sprite2D.visible = false
		animatedSprite2D.visible = true
		#destroySoundPlayer.play()
		animatedSprite2D.play("Destroy_" + COLOR)
		var randomPerkChance = random.randf_range(0, 1)
		if randomPerkChance <= PERK_CHANCE:
			create_perk.emit(get_global_position().x, get_global_position().y)
		return
	
	# safety guard: laser and ball can hit the same block at the same time
	if hits >= MAX_HITS:
		return
	
	sprite2D.texture = textures[COLOR][hits - 1]
	#crackSoundPlayer.play()
	

func _on_animated_sprite_2d_animation_looped():
	animatedSprite2D.stop()
	animatedSprite2D.visible = false
	self.queue_free()
