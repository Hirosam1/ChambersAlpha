class_name EnemyAiController
extends CharacterBody3D

@export var speed = 3.0
@onready var animation_player := $AnimationPlayer

var is_alive = true
var current_target: Node3D
var is_chasing := false

func die() -> void:
	if(is_alive):
		is_alive = false
		animation_player.play("slime_death")
	#queue_free()

func start_chase_target(target: Node) -> void:
	current_target = target
	is_chasing = true
	
func stop_chasing() -> void:
	current_target = null
	is_chasing = false
	
func _process(delta: float) -> void:
	if(is_chasing and is_alive):
		var direction := (current_target.global_position - global_position).normalized()
		velocity = direction*speed
	else:
		velocity = Vector3()
		
	move_and_slide()
