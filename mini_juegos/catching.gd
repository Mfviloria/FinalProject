extends Node2D

var obstacle_1 = preload("res://mini_juegos/fallingobject.tscn")
var obstacle_2 = preload("res://mini_juegos/fallingobject_2.tscn")
var t_1= randf_range(0.3, 1)
var t_2 = randf_range(0.5, 2)

var score=0

func _ready():
	# Inicia el Timer para el primer obstáculo
	if has_node("Timer_1"): # Asegúrate de que el nodo Timer1 existe
		$Timer_1.start(t_1)
		$Timer_1.connect("timeout",_on_Timer1_timeout) # Conecta la señal al método
	else:
		print("Advertencia: No se encontró el nodo 'Timer_1'. El obstáculo 1 no se generará automáticamente.")

	# Inicia el Timer para el segundo obstáculo
	if has_node("Timer_2"): # Asegúrate de que el nodo Timer2 existe
		$Timer_2.start(t_2)
		$Timer_2.connect("timeout",_on_Timer2_timeout) # Conecta la señal al método
	else:
		print("Advertencia: No se encontró el nodo 'Timer_2'. El obstáculo 2 no se generará automáticamente.")
	
	if has_node("HUD/score"):
		$HUD/score.text = "Score: 0"


# Función para el primer obstáculo
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
	
# Función pública para modificar el puntaje
func update_score(amount: int):
	score += amount
	if has_node("HUD/score"):
		$HUD/score.text = "Score: " + str(score)
	if score >= 20:
		var ganaste_scene = preload("res://mini_juegos/win.tscn")  
		get_tree().change_scene_to_packed(ganaste_scene)
