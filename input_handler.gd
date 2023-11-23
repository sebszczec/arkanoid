extends Node

var laser_scene = preload("res://laser.tscn")
var player = null
var logic_handler = null

var shoot_timer = Timer.new()
var shoot_delay = 0.5
var can_shoot = true

signal laser_emited

func _on_timer_completed():
	can_shoot = true
	
func _ready():
	player = get_parent().get_node("Player")
	logic_handler = get_parent().get_node("LogicHandler")
	
	shoot_timer.one_shot = true
	shoot_timer.wait_time = shoot_delay
	shoot_timer.connect("timeout", self._on_timer_completed)
	
	add_child(shoot_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		if can_shoot:
			var laser = laser_scene.instantiate()
			laser.connect("laser_destroyed", logic_handler._on_laser_destroyed)
			laser.position = Vector2(player.position.x, player.position.y - 5)
			add_child(laser)
			
			can_shoot = false
			shoot_timer.start()
			
			laser_emited.emit()
