extends Node
var logic_handler = null


func _ready():
	logic_handler = get_parent().get_node("LogicHandler")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		logic_handler.shoot_laser()
