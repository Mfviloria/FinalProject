extends Area2D



func _on_body_entered(body: CharacterBody2D) -> void:
	GlobalAudioManager.play_sfx(preload("res://mini_juegos-(2)/sonido_atrapar.wav"))
	queue_free()
