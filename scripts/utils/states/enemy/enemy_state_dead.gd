class_name EnemyStateDead extends EnemyStateInterface

@export var hurt_box: HurtBox

func enter(_previous_state: State, _args: Dictionary):
	health.set_collision_layer_value(2,false)
	health.set_collision_layer_value(3,false)
	# We need to set those variables as set_defered:
	# https://forum.godotengine.org/t/cant-set-an-area2d-scene-monitorable-property-as-false-via-script/19194/3?u=zibetnu
	hurt_box.set_deferred("monitoring", false)
	hurt_box.set_deferred("monitorable", false)
	controller.velocity = Vector3()
	animation_player.play("slime_death")
	
