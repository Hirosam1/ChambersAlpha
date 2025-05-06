extends AnimationPlayer

@export
var controller : PlayerHero

func _process(delta: float) -> void:
	if(controller.is_alive and not controller.is_hurt):
		if(controller.velocity.length() > 0.05):
			play("walk")
		else :
			play("idle")
			
func _on_health_damaged(damage: float, current_health: float) -> void:
	if(current_health > 0.0):
		play("hurt")
	else:
		play("die")
