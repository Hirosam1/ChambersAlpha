class_name EnemyAiController
extends CharacterBody3D

@export var speed = 3.0
@onready var animation_player := $AnimationPlayer

var current_target: Node3D
#States
var is_alive = true
var is_hurt := false
var is_chasing := false

func die() -> void:
	if(is_alive):
		is_alive = false
		animation_player.play("slime_death")
		velocity = Vector3()
	#queue_free()
	
func hurt(velocity_knockback: Vector2) -> void:
	if(is_alive):
		animation_player.play("slime_hurt")
		#The target knockback is expeected to be distance travel in seconds,
		#so we divide the vector by our animation duration ("0.6" seconds) so, in time
		#we finish the animation we traveled roughtly the determined distance.
		velocity = Vector3(velocity_knockback.x,0.0,velocity_knockback.y)/0.6
		is_hurt = true

func start_chase_target(target: Node) -> void:
	current_target = target
	is_chasing = true
	
func stop_chasing() -> void:
	current_target = null
	is_chasing = false

func _process(delta: float) -> void:
	if(not is_hurt and is_alive):
		if(is_chasing):
			var direction := (current_target.global_position - global_position).normalized()
			velocity = direction*speed
		else:
			velocity = Vector3()
	move_and_slide()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "slime_hurt"):
		is_hurt = false
		animation_player.play("slime_idle")
