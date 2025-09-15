extends Area2D



func _on_body_entered(body: CharacterBody2D) -> void:
	$"../CanvasLayer/Sprite2D3".visible = false
	$"../CanvasLayer/Sprite2D".visible = false
	$"../CanvasLayer/Next".visible = false
	$"../CanvasLayer/Previous".visible = false
	$"../CanvasLayer/Quit".visible = false
	$"../Sprite2D".visible = false
	GlobalAudioManager.play_sfx(preload("res://video-game-bonus-323603.mp3"))
	await get_tree().create_timer(1.49).timeout
	GlobalAudioManager.play_sfx(preload("res://game-level-complete-143022.mp3"))
	$"../CanvasLayer/Sprite2D2".visible = true
	await get_tree().create_timer(8.0).timeout
	get_tree().change_scene_to_file("res://Industrial world/world_industrial.tscn")
