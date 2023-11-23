extends Node2D

@onready var audio = $BackgroundMusicPlayer
@onready var ball = $Ball
@onready var logic_handler = $LogicHandler


func _ready():
	ball.connect("collided", logic_handler._on_ball_collided)
	audio.play()

func _physics_process(delta):
	pass
	
	
