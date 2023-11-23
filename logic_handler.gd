extends Node

var laser_bullet = preload("res://laser.tscn")
var laser_perk = preload("res://laser_perk.tscn")
var numberOfLaserBeamsValue = null
var ballSpeedValue = null
var numberOfLaserBeams = 0
var player = null

# Perks
# Laser perk
var isLaserPerkActive = false
var laserPerkTimer = Timer.new()
@export var LASER_PERK_TIME = 3;

var shoot_timer = Timer.new()
var shoot_delay = 0.5
var can_shoot = true

signal laser_emited

func _on_shoot_timer_completed():
	can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	numberOfLaserBeamsValue = get_parent().get_node("Labels/NumberOfLaserBeamsValue")
	ballSpeedValue = get_parent().get_node("Labels/BallSpeedValue")
	player = get_parent().get_node("Player")
	
	connect("laser_emited", _on_logic_handler_laser_emited)
	
	shoot_timer.one_shot = true
	shoot_timer.wait_time = shoot_delay
	shoot_timer.connect("timeout", self._on_shoot_timer_completed)
	
	add_child(shoot_timer)
	add_child(laserPerkTimer)

func shoot_laser():
	if isLaserPerkActive:
			if can_shoot:
				var laser = laser_bullet.instantiate()
				laser.connect("laser_destroyed", _on_laser_destroyed)
				laser.position = Vector2(player.position.x, player.position.y - 5)
				add_child(laser)
				
				can_shoot = false
				shoot_timer.start()
				
				laser_emited.emit()

func _on_logic_handler_laser_emited():
	numberOfLaserBeams = numberOfLaserBeams + 1
	numberOfLaserBeamsValue.text = str(numberOfLaserBeams)
	
	
func _on_laser_destroyed():
	numberOfLaserBeams = numberOfLaserBeams - 1
	numberOfLaserBeamsValue.text = str(numberOfLaserBeams)
	

func _on_ball_collided(speed):
	ballSpeedValue.text = "%.2f" % speed
	
func _on_block_create_perk(x, y):
	var perk = laser_perk.instantiate()
	perk.position = Vector2(x, y)
	perk.connect("consumed", _on_laser_perk_consumed)
	call_deferred("add_child", perk)
	
func _on_laser_perk_consumed():
	isLaserPerkActive = true
	
	laserPerkTimer.one_shot = true
	laserPerkTimer.wait_time = LASER_PERK_TIME
	laserPerkTimer.connect("timeout", self._on_laser_perk_timer_completed)
	
	laserPerkTimer.start()
	
func _on_laser_perk_timer_completed():
	isLaserPerkActive = false
