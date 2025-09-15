class_name Flood extends "res://World.gd"
var petróleo1
var petróleo2
var petróleo3
var petróleo4
var petróleo5
var petróleo6
var petróleo7
func _ready():
	$CanvasLayer/Sprite2D2.visible = false
	$CanvasLayer/Previous.visible = false
	GlobalAudioManager.play_music(preload("res://Flood world/musica_fondo.mp3"))
	GlobalAudioManager.set_music_volume(-80)
	petróleo1 = $ParallaxBackground/ParallaxLayer2/petróleo1
	petróleo2 = $ParallaxBackground/ParallaxLayer2/petróleo2
	petróleo3 = $ParallaxBackground/ParallaxLayer2/petróleo3
	petróleo4 = $ParallaxBackground/ParallaxLayer2/petróleo4
	petróleo5 = $ParallaxBackground/ParallaxLayer2/petróleo5
	petróleo6 = $ParallaxBackground/ParallaxLayer2/petróleo6
	petróleo7 = $ParallaxBackground/ParallaxLayer2/petróleo7
	petróleo1.play("Fire")
	petróleo2.play("Fire")
	petróleo3.play("Fire")
	petróleo4.play("Fire")
	petróleo5.play("Fire")
	petróleo6.play("Fire")
	petróleo7.play("Fire")
	
func _on_caída_body_entered(body: CharacterBody2D) -> void:
	GlobalAudioManager.play_sfx(preload("res://Falling.mp3"))
	get_tree().reload_current_scene() 
	
func _on_button_2_pressed() -> void:
	$CanvasLayer/Sprite2D.visible = false
	$CanvasLayer/Next.visible = false
	
func _on_button_pressed() -> void:
	$CanvasLayer/Pausa.visible = true

func _on_quit_pressed() -> void:
	$CanvasLayer/Sprite2D3.visible = false
	$CanvasLayer/Quit.visible = false
	$CanvasLayer/Sprite2D.visible = false
	$CanvasLayer/Next.visible = false
	
func _on_previous_pressed() -> void:
	$CanvasLayer/Previous.visible = false
	$CanvasLayer/Sprite2D3.visible = false
	$CanvasLayer/Sprite2D.visible = true
	$CanvasLayer/Next.visible = true
	$CanvasLayer/Quit.visible = true


func _on_next_pressed() -> void:
	$CanvasLayer/Previous.visible = true
	$CanvasLayer/Sprite2D3.visible = true
	$CanvasLayer/Sprite2D.visible = false
	$CanvasLayer/Next.visible = false
	$CanvasLayer/Quit.visible = false
