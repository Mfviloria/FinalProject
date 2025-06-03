extends Node2D



func _ready():
	$AnimatedSprite2D.play("Fire")



func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	body.take_damage(position.x,1)
