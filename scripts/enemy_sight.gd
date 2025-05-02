extends Area3D

@export var ai_controller: EnemyAiController

func _on_area_entered(area: Area3D) -> void:
	if(area.get_parent_node_3d().name == "Char"):
		ai_controller.start_chase_target(area.get_parent_node_3d())


func _on_area_exited(area: Area3D) -> void:
	if(ai_controller.current_target == area.get_parent_node_3d()):
		ai_controller.stop_chasing()
