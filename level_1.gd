extends Node2D

@onready var audio = $AudioStreamPlayer


func _ready():
	audio.play()

func _physics_process(delta):
	pass
	
	
