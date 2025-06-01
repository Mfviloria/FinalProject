extends AnimatedSprite2D



func _on_infranty_2_mouse_entered() -> void:
	play("shutup")
	



func _on_infranty_2_mouse_exited() -> void:
	play("shutdown")
