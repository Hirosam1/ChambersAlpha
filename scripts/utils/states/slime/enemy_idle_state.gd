extends State

@export var controller: EnemyAiController

var can_chase := false

func enter(previous_state: State):
	if(controller):
		controller.animation_player.play("idle")

func update(delta: float) -> void:
	pass
	
func update_physics(delta: float) -> void:
	pass
	
func exit(next_state: State):
	pass
