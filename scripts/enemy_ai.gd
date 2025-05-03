class_name EnemyAiController
extends CharacterBody3D

@export var speed = 3.0
@onready var animation_player := $AnimationPlayer
@onready var rng := RandomNumberGenerator.new()

var offset_delay_time = .7
var offset_elapsed_time = 0.0

var current_target: PlayerHero
var offset_angle: float = 0.0

#States
var is_alive = true
var is_hurt := false
var is_chasing := false

func die() -> void:
	if(is_alive):
		is_alive = false
		animation_player.play("slime_death")
		velocity = Vector3()
	
func hurt(velocity_knockback: Vector2) -> void:
	if(is_alive):
		is_hurt = true
		animation_player.play("slime_hurt")
		#The target knockback is expeected to be distance travel in seconds,
		#so we divide the vector by our animation duration ("0.6" seconds) so, in time
		#we finish the animation we traveled roughtly the determined distance.
		velocity = Vector3(velocity_knockback.x,0.0,velocity_knockback.y)/0.6

func choose_target(target: Node3D):
	current_target = target

func start_chase_target(target: Node) -> void:
	current_target = target
	is_chasing = true
	
func forget_target() -> void:
	current_target = null
	is_chasing = false
	
func _ready() -> void:
	offset_elapsed_time = rng.randf_range(0.0, offset_delay_time)
	animation_player.speed_scale += randf_range(-0.05,0.05)

func _process(delta: float) -> void:
	offset_elapsed_time += delta
	if(not is_hurt and is_alive):
		if(offset_elapsed_time > offset_delay_time):
			var range := .3
			offset_angle = rng.randf_range(-range,range)
			offset_elapsed_time = 0.0
		if(is_chasing and current_target.is_alive):
			var direction := (current_target.global_position - global_position).normalized()
			direction = direction.rotated(Vector3.UP, global_rotation.y + offset_angle)
			velocity = direction*speed
		else:
			velocity = Vector3()
	move_and_slide()
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "slime_hurt"):
		is_hurt = false
		animation_player.play("slime_idle")
