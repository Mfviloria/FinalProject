extends Node2D

@onready var spawn_point = $Spawn

func _ready() -> void:
	print("NEW")



func _on_button_pressed() -> void:
	$CanvasLayer/Pausa.visible = true
