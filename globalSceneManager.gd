extends Node
class_name SceneManager
var previous_scene: Node = null

func change_to_scene(scene_path: String):
	previous_scene = get_tree().current_scene
	previous_scene.get_parent().remove_child(previous_scene)

	var new_scene = load(scene_path).instantiate()
	get_tree().root.add_child(new_scene)
	get_tree().current_scene = new_scene

func return_to_previous_scene():
	if previous_scene:
		get_tree().current_scene.get_parent().remove_child(get_tree().current_scene)
		get_tree().root.add_child(previous_scene)
		get_tree().current_scene = previous_scene
