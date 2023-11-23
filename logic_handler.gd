extends Node

var numberOfLaserBeamsValue = null
var numberOfLaserBeams = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	numberOfLaserBeamsValue = get_parent().get_node("Labels/NumberOfLaserBeamsValue")


func _on_input_handler_laser_emited():
	numberOfLaserBeams = numberOfLaserBeams + 1
	numberOfLaserBeamsValue.text = str(numberOfLaserBeams)
	
func _on_laser_destroyed():
	numberOfLaserBeams = numberOfLaserBeams - 1
	numberOfLaserBeamsValue.text = str(numberOfLaserBeams)
