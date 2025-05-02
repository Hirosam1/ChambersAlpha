extends AnimationPlayer

@export
var controller : PlayerHero

func _process(delta: float) -> void:
	if(not controller.is_hurt):
		if(controller.velocity.length() > 0.05):
			play("walk")
		else :
			play("idle")
			
func _on_health_damaged(damage: float, current_health: float) -> void:
	play("hurt")
