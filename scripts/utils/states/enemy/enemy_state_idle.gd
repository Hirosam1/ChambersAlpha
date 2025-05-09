class_name EnemyStateIdle extends EnemyStateInterface

var can_chase := false
var target: PlayerHero = null
func _ready() -> void:
	super()

func enter(_previous_state: State, _args: Dictionary):
	animation_player.play("slime_idle")

func update(_delta: float) -> void:
	pass

func update_physics(_delta: float) -> void:
	pass
	
func exit(_next_state: State):
	pass
	
func on_area_sight_in_entered(body: Node3D):
	if(body is PlayerHero):
		change_state.emit(self, "EnemyStateChase", {"target": body})

func on_area_sight_out_entered(body: Node3D):
	#Remembers the reference of the target when it enters the out area.
	if(body is PlayerHero):
		target = body
		
func on_area_sight_out_exited(body: Node3D):
	if(body == target):
		target = null
		
func on_damaged(_p,_c,v):
	change_state.emit(self, "EnemyStateHurt",\
	{"velocity_knockback":v, "target": target})
