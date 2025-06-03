extends Area2D
signal hit
signal core
var already_scored = false

func _on_body_entered(body: CharacterBody2D) -> void:
	hit.emit()

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if not already_scored:
		already_scored = true
		core.emit()
