class_name EnemyStateHurt extends EnemyStateInterface
## The amount on seconds the state will be hurt
@export var hurt_time := 1.0

var last_state: String = ""
var target: PlayerHero = null
var elapsed_time := -5.0
var velocity_knockback := Vector2()

func enter(previous_state: State, args: Dictionary) -> void:
	last_state = previous_state.name.to_lower()
	animation_player.play("slime_hurt")
	elapsed_time = 0.01
	velocity_knockback = args["velocity_knockback"]
	controller.velocity = Vector3(velocity_knockback.x, 0.0, velocity_knockback.y)
	#If it was hit whit when player was inside out area
	if(args.has("target")):
		target = args["target"]
	
func update(delta:float):
	if(elapsed_time > 0):
		elapsed_time += delta
		if(elapsed_time > hurt_time):
			#change_state.emit(self, next_state if (next_state != self.name.to_lower()) else "EnemyStateIdle", {"target": target})
			if(last_state == "enemystatachase"):
				change_state.emit(self, "EnemyStateChase", {})
			else:
				if(target):
					change_state.emit(self, "EnemyStateChase", {"target":target})
				else:
					change_state.emit(self, "EnemyStateIdle", {})
		else:
			controller.velocity = Vector3(velocity_knockback.x, 0.0, velocity_knockback.y)

func on_area_sight_in_entered(body: Node3D):
	#If the player enters the in area while hurt, sets the next state to be chase
	if(body is PlayerHero):
		target = body
		
func on_area_sight_out_exited(body: Node3D):
	if(body == target):
		target = null
		
func exit(_next_state: State):
	controller.velocity = Vector3()
	elapsed_time = -5.0
	velocity_knockback = Vector2()
