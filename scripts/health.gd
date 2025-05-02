class_name Health
extends Area3D
signal  damaged(damage: float, current_health: float)

@export var max_health := 10.0
@export var controller: CharacterBody3D

@onready var current_health := max_health

## Hurts the target affecting health and controller actions 
## such as (animations, knockback, etc)
func hurt(damage: float, velocity_knockback: Vector2)->void:
	current_health -= damage
	if(current_health <= 0):
		controller.die()
		set_collision_layer_value(2,false)
		set_collision_layer_value(3,false)
	else:
		controller.hurt(velocity_knockback)
	damaged.emit(damage, current_health)
