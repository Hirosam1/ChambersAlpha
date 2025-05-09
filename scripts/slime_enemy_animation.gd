extends AnimationPlayer

@onready var rng := RandomNumberGenerator.new()

func _ready() -> void:
	var offset := rng.randf_range(-0.01,0.01)
	speed_scale = 1.0 + offset
	play("slime_idle")
