class_name EnemyStateChase extends EnemyStateInterface

var current_target: PlayerHero = null

func enter(_previous_state: State, args: Dictionary):
	animation_player.play("slime_idle")
	if(args.has("target")):
		current_target = args["target"]
	elif(not current_target):
		change_state.emit(self, "EnemyIdleState", {})
	
func update_physics(_delta: float):
	controller.velocity = Vector3()
	if(current_target and not enemy_sight.check_target(current_target)):
		controller.velocity = controller.speed * \
		(current_target.global_position - controller.global_position).normalized()

func on_area_sight_out_exited(body: Node3D):
	if(body == current_target):
		controller.velocity = Vector3()
		current_target = null
		change_state.emit(self, "EnemyStateIdle", {})
