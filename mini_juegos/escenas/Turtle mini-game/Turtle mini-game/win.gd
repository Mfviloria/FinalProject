extends Control

func _ready():
	$Sprite2D2.play("default")
	



func _on_button_pressed() -> void:
	GlobalSystemLife.resetminigame()
	GlobalSceneManager.return_to_previous_scene()
