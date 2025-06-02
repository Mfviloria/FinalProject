extends Control


func _ready():
	pass
	
func _process(delta):
	pass
	


func StartGame() -> void:
	get_tree().change_scene_to_file("res://FireWorld/scenes/selectCharacter.tscn")


func Settings() -> void:
	pass # Replace with function body.



func Exit() -> void:
	get_tree().quit()
