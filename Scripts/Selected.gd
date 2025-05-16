extends Node2D

var characterSkin 

func _ready():
	characterSkin = $CharacterBody2D/AnimatedSprite2D
	if Global.selected == 0:
		characterSkin.frames = Global.character[0]  # Esto debe ser SpriteFrames
		characterSkin.play("idle")
	elif Global.selected == 1:
		characterSkin.frames = Global.character[1]  # Esto debe ser SpriteFrames
		characterSkin.play("idle")
	elif Global.selected == 2:
		characterSkin.frames = Global.character[2]  # Esto debe ser SpriteFrames
		characterSkin.play("idle")
	else:
		print("No se selecciono ningún perssonaje.")

func _on_area_2d_area_entered(area: Area2D) -> void:
	
	get_tree().change_scene_to_file("res://scenes/world_fire.tscn")
	
