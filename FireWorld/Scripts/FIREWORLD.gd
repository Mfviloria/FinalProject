extends Node2D

var count = 0
var firegrown


func _ready():
	
	$ParallaxBackground/EnemyAnimations/AnimatedSprite2D.play("Fire")
	$ParallaxBackground/EnemyAnimations/AnimatedSprite2D2.play("Fire")
	$ParallaxBackground/EnemyAnimations/AnimatedSprite2D3.play("Fire")
	$ParallaxBackground/Background/Smoke1.play("Smoke")
	$ParallaxBackground/EnemyAnimations/Smoke2.play("Smoke")
	
	$ParallaxBackground/EnemyAnimations/AnimatedSprite2D.play("Fire")
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/control.tscn")
	
func _on_caída_area_entered(area: Area2D) -> void:
	get_tree().reload_current_scene()


func _on_velocity_body_entered(body: CharacterBody2D) -> void:
	body.aumentvelo()



func _on_caída_body_entered(body: CharacterBody2D) -> void:
	get_tree().reload_current_scene()


func _on_normal_v_body_entered(body: CharacterBody2D) -> void:
	body.normalvelo()

func _on_area_2d_2_body_entered(body: CharacterBody2D) -> void:
	get_tree().change_scene_to_file("res://Flood world/worldflood.tscn")


func _on_button_2_pressed() -> void:
	$CanvasLayer/Sprite2D.visible = false
	$CanvasLayer/Button2.visible = false
