extends Control

var is_playing = true

var musica_activada := true
var icono_on: Texture2D = preload("res://musicicon.png")
var icono_off: Texture2D = preload("res://musicof.png")



func _ready():
	update_icon()
	$".".visible = false
	
func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://FireWorld/scenes/control.tscn")

func _on_continue_pressed() -> void:
	get_tree().paused = false
	$".".visible = false 
		
func update_icon():
	if musica_activada:
		$TextureButton.texture_normal = icono_on
	else:
		$TextureButton.texture_normal = icono_off
	
func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_texture_button_pressed() -> void:
	musica_activada = !musica_activada
	update_icon()
	if musica_activada:
		GlobalAudioManager.unmute_all()
	else:
		GlobalAudioManager.mute_all(true)
