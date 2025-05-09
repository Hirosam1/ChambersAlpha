class_name HurtBox extends Area3D

@export var damage = 1.0
#How far the target will travel
@export var knockback := 4.6

func _on_area_entered(area: Node3D) -> void:
	if(area.has_method(	"hurt")):
		var controller :CharacterBody3D = get_parent_node_3d()
		var velocity_knockback :=  controller.velocity.normalized() * knockback
		area.hurt(damage, Vector2(velocity_knockback.x, velocity_knockback.z))
