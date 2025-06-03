extends Control



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Swimturtle MiniGame/water.tscn")
	
func _on_button_2_pressed() -> void:
	GlobalSystemLife.reset()
	GlobalSceneManager.change_to_scene(GlobalSceneManager.previous_scene.scene_file_path)
