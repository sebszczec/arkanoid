extends Control

@onready var audio = $AudioStreamPlayer

func _ready():
	audio.play()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://level_1.tscn")


func _on_quit_pressed():
	get_tree().quit()
