extends CharacterBody3D

## Define its speed in (px/s)
@export
var speed := 2.0

var angular_speed := 0.2
var inpt_mov_vec := Vector2()
var inpt_rot := 0.0
var mouse_mov := Vector2()

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	inpt_mov_vec.x = Input.get_axis("player_mov_left","player_mov_right")
	inpt_mov_vec.y = Input.get_axis("player_mov_up","player_mov_down")
	inpt_mov_vec = inpt_mov_vec.normalized()

func _physics_process(delta: float) -> void:
	var velovity_2d := inpt_mov_vec * speed * delta
	velovity_2d = velovity_2d.rotated(-rotation.y)
	var velocity := Vector3(velovity_2d.x, 0.0, velovity_2d.y)
	rotation.y += angular_speed*-mouse_mov.x*delta
	mouse_mov = Vector2()
	move_and_collide(velocity)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_mov = event.relative
