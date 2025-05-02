extends Node3D


var current_target : Node
var is_chasing := false

func die() -> void:
	queue_free()

func set_chase_target(target: Node) -> void:
	current_target = target
	is_chasing = true
	
func stop_chasing() -> void:
	current_target = null
	is_chasing = false
	
func _process(delta: float) -> void:
	if(is_chasing):
		print("I am chasing!")
