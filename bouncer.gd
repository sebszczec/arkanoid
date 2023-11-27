extends CharacterBody2D

var rotationSpeed = 1


func _physics_process(delta):
	self.rotate(rotationSpeed * delta)
