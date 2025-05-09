class_name EnemyStateInterface extends State
@export_group("AI Controllers")
@export var controller: EnemyAiController
@export var health: Health
@export var enemy_sight: AISight
@export var animation_player: AnimationPlayer

func _ready() -> void:
	health.damaged.connect(on_damaged)
	enemy_sight.area_sight_in.body_entered.connect(on_area_sight_in_entered)
	enemy_sight.area_sight_out.body_entered.connect(on_area_sight_out_entered)
	enemy_sight.area_sight_out.body_exited.connect(on_area_sight_out_exited)
	
			
func on_damaged(_previous_health:float, current_health: float, 
				velocity_knockback: Vector2) -> void:
	if(current_health > 0.0):
		change_state.emit(self, "EnemyStateHurt", {"velocity_knockback": velocity_knockback})
	else:
		health.damaged.disconnect(on_damaged)
		change_state.emit(self, "EnemyStateDead", {})
	
func on_area_sight_in_entered(_body: Node3D):
	pass

func on_area_sight_out_entered(_body: Node3D):
	pass
		
func on_area_sight_out_exited(_body: Node3D):
	pass
