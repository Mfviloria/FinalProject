extends AnimatedSprite2D



func _on_swords_mouse_entered() -> void:
	play("shutup")
	



func _on_swords_mouse_exited() -> void:
	play("shutdown")
