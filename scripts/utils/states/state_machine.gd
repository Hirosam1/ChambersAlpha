extends Node
class_name StateMachine

@export var initial_state: State

var states: Dictionary
var current_state: State

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.change_state.connect(on_state_changed)

	if(initial_state):
		current_state = initial_state
		current_state.enter(null, {})

func _process(delta: float) -> void:
	if(current_state):
		current_state.update(delta)
	
func _physics_process(delta: float) -> void:
	if(current_state):
		current_state.update_physics(delta)
	
func on_state_changed(from_state: State, next_state_name: String, args: Dictionary) -> void:
	if(from_state != current_state):
		return
	
	var next_state: State = states.get(next_state_name.to_lower())
	if(!next_state):
		return
	
	if(current_state): 
		current_state.exit(next_state)
	#print("State chaged " + current_state.name.to_lower() + " to " + next_state.name.to_lower())
	next_state.enter(current_state, args)
	current_state = next_state
