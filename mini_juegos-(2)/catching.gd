extends Node2D

var obstacle_1 = preload("res://mini_juegos-(2)/fallingobject.tscn")
var obstacle_2 = preload("res://mini_juegos-(2)/fallingobject_2.tscn")
var t_1= randf_range(0.3, 1)
var t_2 = randf_range(0.5, 2)

var score=0

func _ready():
	$Timer_1.stop()
	$Timer_1.paused = true
	$Timer_2.stop()
	$Timer_2.paused = true

	if not $Timer_1.is_connected("timeout", Callable(self, "_on_Timer1_timeout")):
		$Timer_1.connect("timeout", Callable(self, "_on_Timer1_timeout"))

	if not $Timer_2.is_connected("timeout", Callable(self, "_on_Timer2_timeout")):
		$Timer_2.connect("timeout", Callable(self, "_on_Timer2_timeout"))

	GlobalAudioManager.play_music(preload("res://Ian Post - 8 Bit Samba - No FX.mp3"))

func _on_Timer1_timeout():
	var screen = get_viewport_rect().size
	# Genera una posición X aleatoria dentro de la pantalla, Y comienza fuera por encima
	var position = Vector2(randf_range(0, screen.x), -600)

	var new_obstacle = obstacle_1.instantiate()# Instancia el obstáculo 1
	new_obstacle.position = position
	add_child(new_obstacle)
	$Timer_1.start(randf_range(0.5, 2)) # Reinicia el timer para el próximo obstáculo 1

# Función para el segundo obstáculo
func _on_Timer2_timeout():
	var screen = get_viewport_rect().size
	# Genera una posición X aleatoria para el segundo obstáculo, Y también comienza por encima
	# Puedes ajustar el rango de posición para el segundo obstáculo si quieres que aparezca en otro lugar
	var position = Vector2(randf_range(0, screen.x), -800) # Por ejemplo, un poco más arriba

	var new_obstacle_2 = obstacle_2.instantiate() # Instancia el obstáculo 2
	new_obstacle_2.position = position
	add_child(new_obstacle_2)
	$Timer_2.start(randf_range(0.5, 2)) 
	
func update_score(amount: int):
	score += amount
	if has_node("HUD/score"):
		$HUD/score.text = "Score: " + str(score)
	if score >= 20:
		GlobalAudioManager.stop_specific_music(preload("res://Ian Post - 8 Bit Samba - No FX.mp3"))
		GlobalAudioManager.play_sfx(preload("res://WhatsApp-Audio-2025-06-04-at-11.15.29-PM.mp3"))
		var ganaste_scene = preload("res://mini_juegos-(2)/win.tscn")  
		get_tree().change_scene_to_packed(ganaste_scene)



func _on_button_pressed() -> void:
	$Panel.visible = false
	$Label.visible = false
	$Button.visible = false
	
	$Timer_1.paused = false
	$Timer_2.paused = false
	
	$Timer_1.start(randf_range(0.3, 1))
	$Timer_2.start(randf_range(0.5, 2))
	
	if has_node("HUD/score"):
		$HUD/score.text = "Score: 0"
