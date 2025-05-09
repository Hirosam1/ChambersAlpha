class_name AISight extends Node3D

@export var ai_controller: EnemyAiController
#https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_exports.html#exporting-bit-flags
@export_flags_3d_physics var obstacle_mask: int

@onready var area_sight_in :Area3D = $AreaOfSightIn
@onready var area_sight_out :Area3D = $AreaOfSightOut

func check_target(target: Node3D) -> Dictionary:
	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(global_position, 
	target.global_position, obstacle_mask)
	return space_state.intersect_ray(query)
