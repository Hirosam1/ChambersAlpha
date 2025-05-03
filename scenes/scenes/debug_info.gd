extends CanvasLayer

@export var hero_controller : PlayerHero

@onready var health_tag := $BoxContainer/Health

func _process(delta: float) -> void:
	var health: Health = hero_controller.get_node("Health")
	health_tag.text = "Health: " + str(health.current_health)
