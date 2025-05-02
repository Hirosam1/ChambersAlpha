class_name PlayerHero
extends CharacterBody3D

## Define its speed in (px/s)
@export
var speed := 2.0

@export
var mouse_sensitivity := 0.25

var inpt_mov_vec := Vector2()
var inpt_rot := 0.0
var mouse_mov := Vector2()
var is_captured_mode := true
#States
var is_hurt := false
var is_alive := true

func die(): 
	print("I died! XP")
	is_alive = false
	velocity = Vector3()
	
func hurt(velocity_knockback: Vector2) -> void:
	is_hurt = true
	velocity = Vector3(velocity_knockback.x, 0.0, velocity_knockback.y)/1.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	# Get player input
	inpt_mov_vec.x = Input.get_axis("player_mov_left","player_mov_right")
	inpt_mov_vec.y = Input.get_axis("player_mov_up","player_mov_down")
	# Handle when player presses 'esc' and stop rotating camera
	if(Input.is_action_just_pressed("key_esc")):
		is_captured_mode = !is_captured_mode
		if(is_captured_mode):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
	if(is_captured_mode):
		# Rotates camera
		rotation.y += mouse_sensitivity*-mouse_mov.x*delta
	# Resets variable
	mouse_mov = Vector2()
	if(is_alive and not is_hurt):
		# Checks if there were an player input, using a small value
		if(abs(inpt_mov_vec.x) + abs(inpt_mov_vec.y) >= 0.001):
			inpt_mov_vec = inpt_mov_vec.normalized()
			var velovity_2d := inpt_mov_vec * speed
			velovity_2d = velovity_2d.rotated(-rotation.y)
			velocity = Vector3(velovity_2d.x, 0.0, velovity_2d.y)
		else:
			velocity = Vector3()
		
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Saves mouse relative movment
		mouse_mov = event.relative


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name  == "hurt"):
		is_hurt = false
