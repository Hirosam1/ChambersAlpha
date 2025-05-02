extends AnimationPlayer

@export
var controller : CharacterBody3D

func _process(delta: float) -> void:
	if(controller.velocity.length() > 0.05):
		play("walk")
	else :
		play("idle")
	
