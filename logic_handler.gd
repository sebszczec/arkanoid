extends Node

var laser_bullet = preload("res://laser.tscn")
var perkScene = preload("res://perk.tscn")
var numberOfLaserBeamsValue = null
var ballSpeedValue = null
var numberOfLaserBeams = 0
var player = null
var ball = null

# Perks
# Laser perk
var isLaserPerkActive = false
var laserPerkTimer = Timer.new()
@export var LASER_PERK_TIME = 3;

var shoot_timer = Timer.new()
var shoot_delay = 0.5
var can_shoot = true

signal laser_emited

# Speed perk
const BALL_SPEED_NORMAL = 200
const BALL_SPEED_FAST = 400

var speedPerkTimer = Timer.new()
@export var SPEED_PERK_TIME = 4

func _on_shoot_timer_completed():
	can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	numberOfLaserBeamsValue = get_parent().get_node("Labels/NumberOfLaserBeamsValue")
	ballSpeedValue = get_parent().get_node("Labels/BallSpeedValue")
	player = get_parent().get_node("Player")
	ball = get_parent().get_node("Ball")
	
	connect("laser_emited", _on_logic_handler_laser_emited)
	
	shoot_timer.one_shot = true
	shoot_timer.wait_time = shoot_delay
	shoot_timer.connect("timeout", self._on_shoot_timer_completed)
	speedPerkTimer.connect("timeout", self._on_speed_perk_timer_completed)
	laserPerkTimer.connect("timeout", self._on_laser_perk_timer_completed)
	
	add_child(shoot_timer)
	add_child(laserPerkTimer)
	add_child(speedPerkTimer)

func shoot_laser():
	if isLaserPerkActive:
		if !can_shoot:
			return
			
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
	var perk = perkScene.instantiate()
	perk.position = Vector2(x, y)
	perk.set_type(get_radnom_perk_type())
	
	if perk.type == perk.Type.Laser:
		perk.connect("consumed", _on_laser_perk_consumed)
	else:
		perk.connect("consumed", _on_speed_perk_consumed)
		
	call_deferred("add_child", perk)
	
	
func _on_speed_perk_consumed():
	ball.SPEED = BALL_SPEED_FAST
	speedPerkTimer.one_shot = true
	speedPerkTimer.wait_time = SPEED_PERK_TIME
	speedPerkTimer.start()
	
	
func _on_speed_perk_timer_completed():
	ball.SPEED = BALL_SPEED_NORMAL

	
func _on_laser_perk_consumed():
	isLaserPerkActive = true
	
	player.show_gun()
	laserPerkTimer.one_shot = true
	laserPerkTimer.wait_time = LASER_PERK_TIME
	laserPerkTimer.start()
	
	
func _on_laser_perk_timer_completed():
	player.hide_gun()
	isLaserPerkActive = false


func get_radnom_perk_type():
	var generator = RandomNumberGenerator.new()
	var chance = generator.randf_range(0, 1)
	if chance < 0.5:
		return 0 # Laser
		
	return 1 # Speed
	
