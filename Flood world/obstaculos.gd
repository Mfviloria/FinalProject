extends Area2D

class_name Obstacle

var damage = 1

@onready var positionenemy = position.x

func _on_body_entered(body: CharacterBody2D) -> void:
	body.take_damage(positionenemy,damage)
