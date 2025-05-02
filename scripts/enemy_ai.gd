class_name EnemyAiController
extends CharacterBody3D

@export var speed = 3.0

var current_target: Node3D
var is_chasing := false

func die() -> void:
	queue_free()

func start_chase_target(target: Node) -> void:
	current_target = target
	is_chasing = true
	
func stop_chasing() -> void:
	current_target = null
	is_chasing = false
	
func _process(delta: float) -> void:
	if(is_chasing):
		var direction := (current_target.global_position - global_position).normalized()
		velocity = direction*speed
	else:
		velocity = Vector3()
		
	move_and_slide()
