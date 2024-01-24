extends Node


@export var max_health: float = 100.
var current_health: float = max_health

func apply_damage(damage: float) -> void:
	current_health -= damage
	if current_health <= 0:
		# get parent and delete from scene
		get_parent().queue_free()

