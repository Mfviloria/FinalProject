extends AnimatedSprite2D



func _on_character_body_2d_mouse_entered() -> void:
	play("shutup")
	



func _on_character_body_2d_mouse_exited() -> void:
	play("shutdown")
