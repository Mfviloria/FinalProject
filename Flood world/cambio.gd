extends Area2D



func _on_body_entered(body: CharacterBody2D) -> void:
	get_tree().change_scene_to_file("res://Industrial world/world_industrial.tscn")
