extends Area3D
## How fast (px/s) the spell will move.
@export
var speed := 5.0

var is_cast := false
var direction := Vector3()

func ready_spell(direction: Vector3):
	self.direction = direction
	is_cast = true

func _process(delta: float) -> void:
	if(is_cast):
		position += speed * direction * delta

func _on_body_entered(body: Node3D) -> void:
	queue_free()
