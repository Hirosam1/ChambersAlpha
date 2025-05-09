class_name EnemySight extends Node3D

@export var ai_controller: Node3D
#https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_exports.html#exporting-bit-flags
@export_flags_3d_physics var obstacle_mask: int

var can_chase := false

func _on_area_of_sight_in_body_entered(body) -> void:
	if(body is PlayerHero):
		ai_controller.choose_target(body)
		can_chase = true

func _on_area_of_sight_out_body_entered(body: Node3D) -> void:
	if(body is PlayerHero):
		ai_controller.choose_target(body)

func _on_area_of_sight_out_body_exited(body) -> void:
	if(ai_controller and ai_controller.current_target == body):
		can_chase = false
		ai_controller.forget_target()

func _physics_process(delta: float) -> void:
	if(can_chase):
		var space_state := get_world_3d().direct_space_state
		var query := PhysicsRayQueryParameters3D.create(global_position, 
		ai_controller.current_target.global_position, obstacle_mask)
		var result := space_state.intersect_ray(query)
		if(not result):
			ai_controller.is_chasing = true
		else:
			ai_controller.is_chasing = false

func _on_health_damaged(damage: float, current_health: float) -> void:
	if(ai_controller.current_target):
		ai_controller.is_chasing = true
