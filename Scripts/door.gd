extends Node2D

@onready var indicator = $Label
@onready var area_2d: Area2D = $Area2D
var pasar = false

func _ready():
	indicator.visible = false	

func _process(delta):
	if pasar and Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to_file("res://scenes/world_fire.tscn")

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("_on_area_2d_area_entered area : ", area)
	indicator.visible = true
	pasar = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	indicator.visible = false
	print("_on_area_2d_area_exited area : ", area)
	pasar = false
