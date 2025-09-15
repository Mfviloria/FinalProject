class_name ForestFire extends "res://World.gd"
var count = 0
var firegrown

func _ready():
	$CanvasLayer/Sprite2D2.visible = false
	$CanvasLayer/Previous.visible = false
	$ParallaxBackground/EnemyAnimations/AnimatedSprite2D.play("Fire")
	$ParallaxBackground/EnemyAnimations/AnimatedSprite2D2.play("Fire")
	$ParallaxBackground/EnemyAnimations/AnimatedSprite2D3.play("Fire")
	$ParallaxBackground/Background/Smoke1.play("Smoke")
	$ParallaxBackground/EnemyAnimations/Smoke2.play("Smoke")
	$ParallaxBackground/EnemyAnimations/AnimatedSprite2D.play("Fire")


func _on_velocity_body_entered(body: CharacterBody2D) -> void:
	body.aumentvelo()

func _on_caída_body_entered(body: CharacterBody2D) -> void:
	GlobalAudioManager.play_sfx(preload("res://Falling.mp3"))
	get_tree().reload_current_scene()

func _on_normal_v_body_entered(body: CharacterBody2D) -> void:
	body.normalvelo()

func _on_area_2d_2_body_entered(body: CharacterBody2D) -> void:
	$FireCrystal.visible = false
	GlobalAudioManager.play_sfx(preload("res://video-game-bonus-323603.mp3"))
	await get_tree().create_timer(1.49).timeout
	GlobalAudioManager.play_sfx(preload("res://game-level-complete-143022.mp3"))
	$CanvasLayer/Sprite2D2.visible = true
	await get_tree().create_timer(8.0).timeout
	get_tree().change_scene_to_file("res://Flood world/worldflood.tscn")

func _on_button_2_pressed() -> void:
	$CanvasLayer/Quit.visible = false
	$CanvasLayer/Next.visible = false
	$"CanvasLayer/1".visible = false
	$"CanvasLayer/2".visible = false

func _on_button_pressed() -> void:
	get_tree().paused = true
	$CanvasLayer/Pausa.visible = true
	
func _on_caída_area_entered(area: Area2D) -> void:
	get_tree().reload_current_scene()

func _on_previous_pressed() -> void:
	$"CanvasLayer/1".visible = true
	$"CanvasLayer/2".visible = false
	$CanvasLayer/Previous.visible = false
	$CanvasLayer/Next.visible = true
	$CanvasLayer/Quit.visible = true

func _on_next_pressed() -> void:
	$"CanvasLayer/1".visible = false
	$"CanvasLayer/2".visible = true
	$CanvasLayer/Previous.visible = true
	$CanvasLayer/Next.visible = false
	$CanvasLayer/Quit.visible = false
