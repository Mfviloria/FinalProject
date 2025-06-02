extends Node2D

var fire
var fire2
var fire3
var sm
var count = 0
var firegrown

func _ready():
	fire = $ParallaxBackground/EnemyAnimations/AnimatedSprite2D
	fire2 = $ParallaxBackground/EnemyAnimations/AnimatedSprite2D2
	fire3 = $ParallaxBackground/EnemyAnimations/AnimatedSprite2D3
	sm = $ParallaxBackground/Background/Smoke1
	
	fire.play("Fire")
	fire2.play("Fire")
	fire3.play("Fire")
	sm.play("Smoke")
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
