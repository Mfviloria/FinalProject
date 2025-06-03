extends Node2D


func _on_button_pressed() -> void:
	GlobalSystemLife.resetminigame()
	GlobalSceneManager.return_to_previous_scene()
