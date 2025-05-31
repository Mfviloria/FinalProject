extends Area2D

func _ready():
	$"../AnimatedSprite2D".play("Fire")

func _on_body_entered(body: CharacterBody2D) -> void:
	body.take_damage(position.x)
