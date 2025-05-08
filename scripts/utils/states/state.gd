extends Node
class_name State

signal change_state (from_state: State, next_state_name: String)

func enter(previous_state: State) -> void:
	pass

func exit(next_state: State) -> void:
	pass

func update(delta: float) -> void:
	pass

func update_physics(delta: float) -> void:
	pass

func update_input(input: InputEvent) -> void:
	pass
