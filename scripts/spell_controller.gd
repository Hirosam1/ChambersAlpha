extends Area3D
## how much the projectile will damage hit target.
@export var damage := 4.0
## How far in units the damage will move the target (0 means no knockback).
@export var knockback := 0.8
## How fast (px/s) the spell will move.
@export var speed := 5.0
## How long in seconds the spell lives.
@export var lifetime := 4.0

var is_cast := false
var direction := Vector3()
var elapsed_time : float

## Necessary for spell to work, pass direction of travel
func ready_spell(direction: Vector3):
	elapsed_time = 0.0
	self.direction = direction.normalized()
	is_cast = true

func _process(delta: float) -> void:
	# Accumulate time
	elapsed_time += delta
	if(elapsed_time >= lifetime):
		queue_free()
	elif(is_cast):
		position += speed * direction * delta

func _on_body_entered(body: Node3D) -> void:
	queue_free()

func _on_area_entered(area: Health) -> void:
	if(area is Health):
		var knockback_velocity := direction * knockback
		area.hurt(damage, Vector2(knockback_velocity.x,knockback_velocity.z))
		queue_free()
