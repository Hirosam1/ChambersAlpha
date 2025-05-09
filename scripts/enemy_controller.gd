class_name EnemyAiController extends CharacterBody3D

@export var speed = 3.0
@onready var animation_player := $SlimeAnimationPlayer
@onready var rng := RandomNumberGenerator.new()

var offset_delay_time = .8
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
		#animation_player.play("slime_death")
		velocity = Vector3()
	
func choose_target(target: Node3D):
	current_target = target

func start_chase_target(target: Node) -> void:
	current_target = target
	# is_chasing = true
	
func forget_target() -> void:
	current_target = null
	# is_chasing = false
	
func _ready() -> void:
	offset_elapsed_time = rng.randf_range(0.0, offset_delay_time)
	animation_player.speed_scale += randf_range(-0.05,0.05)
	
func _process(_delta: float) -> void:
	move_and_slide()
