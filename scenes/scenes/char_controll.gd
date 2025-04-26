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

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	inpt_mov_vec.x = Input.get_axis("player_mov_left","player_mov_right")
	inpt_mov_vec.y = Input.get_axis("player_mov_up","player_mov_down")
	if(Input.is_action_just_pressed("key_esc")):
		is_captured_mode = !is_captured_mode
		if(is_captured_mode):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	inpt_mov_vec = inpt_mov_vec.normalized()

func _physics_process(delta: float) -> void:
	var velovity_2d := inpt_mov_vec * speed * delta
	velovity_2d = velovity_2d.rotated(-rotation.y)
	var velocity := Vector3(velovity_2d.x, 0.0, velovity_2d.y)
	if(is_captured_mode):
		rotation.y += mouse_sensitivity*-mouse_mov.x*delta
	mouse_mov = Vector2()
	move_and_collide(velocity)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_mov = event.relative
