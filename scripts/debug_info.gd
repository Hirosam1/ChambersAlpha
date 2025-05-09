extends CanvasLayer

@export var hero_controller : PlayerHero

@onready var health_tag := $BoxContainer/Health

func _process(_delta: float) -> void:
	var health = hero_controller.get_node("Health")
	health_tag.text = "Health: " + str("%0.2f" % health.current_health)
