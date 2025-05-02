extends Node3D

@export var ai_controller: EnemyAiController

func _on_area_of_sight_in_area_entered(area) -> void:
	print(area)

func _on_area_of_sight_in_body_entered(body) -> void:
	if(body is PlayerHero):
		ai_controller.start_chase_target(body)


func _on_area_of_sight_out_body_exited(body) -> void:
	if(ai_controller.current_target == body):
		ai_controller.stop_chasing()
