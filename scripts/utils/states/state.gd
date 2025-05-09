extends Node
class_name State

signal change_state (from_state: State, next_state_name: String, args: Dictionary)

func _ready() -> void:
	print(self.name)

func enter(_previous_state: State, _args: Dictionary) -> void:
	pass

func exit(_next_state: State) -> void:
	pass

func update(_delta: float) -> void:
	pass

func update_physics(_delta: float) -> void:
	pass

func update_input(_input: InputEvent) -> void:
	pass
