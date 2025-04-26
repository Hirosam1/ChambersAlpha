extends Node3D

## Delay in secnds between each spell fire.
@export
var delay := 1.0

@export
var spell_asset : PackedScene

var cast_elapsed_time := 0.0

func _process(delta: float) -> void:
	cast_elapsed_time += delta
	if(Input.is_action_pressed("fire") and cast_elapsed_time >= delay):
		var spell: Area3D = spell_asset.instantiate()
		get_tree().current_scene.add_child(spell)
		spell.position = global_position
		spell.ready_spell(Vector3.FORWARD.rotated(Vector3.MODEL_TOP,global_rotation.y))
		cast_elapsed_time = 0.0
