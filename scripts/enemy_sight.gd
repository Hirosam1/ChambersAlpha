extends Node3D

@export var ai_controller: EnemyAiController
#https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_exports.html#exporting-bit-flags
@export_flags_3d_physics var obstacle_mask: int

func _on_area_of_sight_in_body_entered(body) -> void:
	if(body is PlayerHero):
		#ai_controller.start_chase_target(body)
		ai_controller.choose_target(body)


func _on_area_of_sight_out_body_exited(body) -> void:
	if(ai_controller.current_target == body):
		ai_controller.forget_target()
		
		
func _physics_process(delta: float) -> void:
	if(ai_controller.current_target):
		var space_state := get_world_3d().direct_space_state
		space_state.set
		var query := PhysicsRayQueryParameters3D.create(global_position, 
		ai_controller.current_target.global_position, obstacle_mask)
		var result := space_state.intersect_ray(query)
		if(not result):
			ai_controller.is_chasing = true
		else:
			ai_controller.is_chasing = false
