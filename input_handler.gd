extends Node

var laser_scene = preload("res://laser.tscn")
var player = null
var numberOfLaserBeamsValue = null

var shoot_timer = Timer.new()
var shoot_delay = 0.5
var can_shoot = true

var numberOfLaserBeams = 0

func _on_timer_completed():
	can_shoot = true
	
func _ready():
	player = get_parent().get_node("Player")
	numberOfLaserBeamsValue = get_parent().get_node("Labels/NumberOfLaserBeamsValue")
	
	shoot_timer.one_shot = true
	shoot_timer.wait_time = shoot_delay
	shoot_timer.connect("timeout", self._on_timer_completed)
	
	add_child(shoot_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		if can_shoot:
			var laser = laser_scene.instantiate()
			laser.position = Vector2(player.position.x, player.position.y - 5)
			numberOfLaserBeams = numberOfLaserBeams + 1
			numberOfLaserBeamsValue.text = str(numberOfLaserBeams)
			add_child(laser)
			
			can_shoot = false
			shoot_timer.start()
