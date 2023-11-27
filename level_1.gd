extends Node2D

@onready var audio = $BackgroundMusicPlayer
@onready var ball = $Ball
@onready var logic_handler = $LogicHandler


func _ready():
	#TODO: shouldn't this be in ball.gd?
	ball.connect("collided", logic_handler._on_ball_collided)
	audio.play()
	
	get_tree().set_debug_collisions_hint(false)

func _physics_process(delta):
	pass
	
	
