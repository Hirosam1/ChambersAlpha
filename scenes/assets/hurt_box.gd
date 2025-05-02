extends Area3D

@export var damage = 1.0
#How far the target will travel
@export var knockback := 4.6

func _on_area_entered(area: Health) -> void:
	if(area is Health):
		var controller :EnemyAiController = get_parent_node_3d()
		var velocity_knockback :=  controller.velocity.normalized() * knockback
		area.hurt(damage, Vector2(velocity_knockback.x, velocity_knockback.z))


func _on_health_damaged(damage: float, current_health: float) -> void:
	if(current_health <= 0):
		monitoring = false
		monitorable = false
