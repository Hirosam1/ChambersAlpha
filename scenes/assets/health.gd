extends Area3D

@export
var max_health := 2.0
var current_health := max_health

@export
var controller: Node3D

func hurt(damage: float)->void:
	current_health -= damage
	if(current_health <= 0):
		controller.die()
