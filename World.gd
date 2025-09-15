extends Node

class_name World

func _on_caída_body_entered(body: CharacterBody2D) -> void:
	get_tree().reload_current_scene()

func _on_button_2_pressed() -> void:
	$CanvasLayer/Sprite2D.visible = false 
	$CanvasLayer/Button2.visible = false

func _on_button_pressed() -> void:
	$CanvasLayer/Pausa.visible = true
