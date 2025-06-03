extends Control



func _on_button_pressed() -> void:
	GlobalSystemLife.reset()
	GlobalSceneManager.change_to_scene(GlobalSceneManager.previous_scene.scene_file_path)
