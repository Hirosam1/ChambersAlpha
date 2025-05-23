extends Node3D

## Delay in secnds between each spell fire.
@export
var delay := 1.0

@export
var spell_asset : PackedScene

@onready var cast_elapsed_time := delay

var is_alive = true

func _process(delta: float) -> void:
	cast_elapsed_time += delta
	if(is_alive and Input.is_action_pressed("fire") and cast_elapsed_time >= delay):
		# Instantiate an asset defined on @export
		var spell: Area3D = spell_asset.instantiate()
		# Add the asset on the 'main' three (the current scene)
		get_tree().current_scene.add_child(spell)
		# Updates its position to be the same as the SpellSpawner
		spell.position = global_position
		# We rotate a 'foward' vector with our rotation on the 'top' axis
		spell.ready_spell(Vector3.FORWARD.rotated(Vector3.MODEL_TOP,global_rotation.y))
		cast_elapsed_time = 0.0


func _on_health_damaged(damage: float, current_health: float) -> void:
	if(current_health <= 0):
		is_alive = false
		
