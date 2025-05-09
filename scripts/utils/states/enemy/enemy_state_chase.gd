class_name EnemyStateChase extends EnemyStateInterface

var current_target: PlayerHero = null
## time in seconds that the path updates to move slighy at random angle
@export var update_path_time := 1.2

@onready var rng = RandomNumberGenerator.new()
@onready var elapsed_time := update_path_time
var offset := 0.0

func enter(_previous_state: State, args: Dictionary):
	animation_player.play("slime_idle")
	elapsed_time = 0.0
	if(args.has("target")):
		current_target = args["target"]
	elif(not current_target):
		change_state.emit(self, "EnemyIdleState", {})
	
func update_physics(delta: float):
	controller.velocity = Vector3()
	if(elapsed_time > update_path_time):
		elapsed_time = 0.0
		offset = rng.randf_range(-0.17,0.17)
	if(current_target and not enemy_sight.check_target(current_target) and current_target.is_alive):
		elapsed_time += delta
		var direction := (current_target.global_position - controller.global_position).normalized()
		direction = direction.rotated(Vector3.UP, offset)
		controller.velocity = controller.speed * direction
		
func on_area_sight_out_exited(body: Node3D):
	if(body == current_target):
		controller.velocity = Vector3()
		current_target = null
		change_state.emit(self, "EnemyStateIdle", {})
