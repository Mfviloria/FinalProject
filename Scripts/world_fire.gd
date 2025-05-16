extends Node2D

var fire
var fire2
var fire3
func _ready():
	fire = $ParallaxBackground/ParallaxLayer2/AnimatedSprite2D
	fire2 = $ParallaxBackground/ParallaxLayer2/AnimatedSprite2D2
	fire3 = $ParallaxBackground/ParallaxLayer2/AnimatedSprite2D3
	
	fire.play("Fire")
	fire2.play("Fire")
	fire3.play("Fire")



func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Pierde una vida")



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/selectCharacter.tscn")


func _on_area_2d_body_entered(body) -> void:
	print("DAÑO")
	body.take_damage()
	
