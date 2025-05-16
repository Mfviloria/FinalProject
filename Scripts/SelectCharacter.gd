extends Control

@onready var swords = $swords/Swords
@onready var infantry = $Infranty2/Infranty
@onready var destroyer = $CharacterBody2D/Destroyer


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world_1.tscn")




func _on_area_2d_mouse_entered() -> void:
	print("Cursor sobre swords")
	swords.play("shutup")


func _on_area_2d_mouse_exited() -> void:
	
	swords.play("shutdown")



func _on_area_2d_2_mouse_entered() -> void:
	print("Infantry sobre swords")
	infantry.play("shutup")
	

func _on_area_2d_2_mouse_exited() -> void:
	infantry.play("shutdown")



func _on_area_2d_3_mouse_entered() -> void:
	print("Destroyer sobre swords")
	destroyer.play("shutup")


func _on_area_2d_3_mouse_exited() -> void:
	destroyer.play("shutdown")
