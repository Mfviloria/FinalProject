extends Area2D

signal hit

func _on_body_entered(body: CharacterBody2D) -> void:
	hit.emit()
