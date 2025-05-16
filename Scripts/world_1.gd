extends Node2D

@onready var spawn_point = $Spawn

func _ready() -> void:
	print("NEW")



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/selectCharacter.tscn")
