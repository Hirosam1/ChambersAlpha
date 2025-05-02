extends Area3D

@export
var max_health := 2.0
@export
var controller: EnemyAiController

@onready var current_health := max_health

func hurt(damage: float)->void:
	current_health -= damage
	if(current_health <= 0):
		controller.die()
