extends Node2D

@onready var indicator = $Label
@onready var area_2d: Area2D = $Area2D
var pasar = false

func _ready():
	indicator.visible = false	

func _process(delta):
	if pasar and Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to_file("res://scenes/world_fire.tscn")

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	indicator.visible = true
	pasar = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	indicator.visible = false
	pasar = false
