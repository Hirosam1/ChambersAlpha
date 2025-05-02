class_name Health
extends Area3D

@export
var max_health := 2.0
@export
var controller: EnemyAiController

@onready var current_health := max_health

func hurt(damage: float, velocity_knockback: Vector2)->void:
	current_health -= damage
	if(current_health <= 0):
		controller.die()
		set_collision_layer_value(2,false)
		set_collision_layer_value(3,false)
	else:
		controller.hurt(velocity_knockback)
