extends Node2D

var fire
var fire2
var fire3
var sm
var count = 0

func _ready():
	fire = $ParallaxBackground/ParallaxLayer2/AnimatedSprite2D
	fire2 = $ParallaxBackground/ParallaxLayer2/AnimatedSprite2D2
	fire3 = $ParallaxBackground/ParallaxLayer2/AnimatedSprite2D3
	sm = $ParallaxBackground/ParallaxLayer2/Smoke1
	fire.play("Fire")
	fire2.play("Fire")
	fire3.play("Fire")
	sm.play("Smoke")
	$ParallaxBackground/ParallaxLayer3/AnimatedSprite2D.play("Fire")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/control.tscn")


	
func _on_caída_area_entered(area: Area2D) -> void:
	get_tree().reload_current_scene()
