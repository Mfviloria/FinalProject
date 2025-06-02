extends Control

@onready var Animated = $Sprite2D2
var num = -1

func _on_infrantyman_pressed() -> void:
	print("Selected Infranty")
	Animated.flip_h = true
	Animated.frames = Global.character[0]
	Animated.play("idle")
	num = 0


func _on_destroyer_pressed() -> void:
	print("Selected Destroyer")
	Animated.flip_h = true
	Animated.frames = Global.character[1]
	Animated.play("idle")
	Global.setCurrentPlayer(Global.character[1])
	num = 1


func _on_swordsman_pressed() -> void:
	print("Selected Swordsman")
	Animated.flip_h = true
	Animated.frames = Global.character[2]
	Animated.play("idle")
	Global.setCurrentPlayer(Global.character[2])
	num = 2
	
func _on_select_pressed() -> void:
	Global.selected = num
	get_tree().change_scene_to_file("res://FireWorld/scenes/world_1.tscn")
	
	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://FireWorld/scenes/control.tscn")
