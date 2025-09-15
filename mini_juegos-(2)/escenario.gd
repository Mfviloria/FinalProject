extends Node2D
class_name Minigame
@onready var manecilla = $manecilla
@onready var boton = $Button
@onready var temporizador = $Timer

var velocidad = 0.0
var girando = false

func _ready():
	# Verificar que todos los nodos existen
	if boton == null:
		print("ERROR: No se encontró el nodo boton")
		return
	if manecilla == null:
		print("ERROR: No se encontró el nodo manecilla/ma")
		return
	if temporizador == null:
		print("ERROR: No se encontró el nodo Timer")
		return
	
	# Conectar señales
	boton.pressed.connect(_on_boton_presionado)
	temporizador.timeout.connect(_on_temporizador_terminado)
	
	print("Ruleta inicializada correctamente")
	print("Manecilla encontrada: ", manecilla != null)
	print("Botón encontrado: ", boton != null)
	print("Timer encontrado: ", temporizador != null)
	
	# DIAGNÓSTICO COMPLETO DEL BOTÓN
	print("=== DIAGNÓSTICO DEL BOTÓN ===")
	print("Posición del botón: ", boton.position)
	print("Tamaño del botón: ", boton.size)
	print("Visible: ", boton.visible)
	print("Disabled: ", boton.disabled)
	print("Texto del botón: ", boton.text)
	print("Modulate: ", boton.modulate)
	
	# Verificar si el botón está siendo bloqueado por otros nodos
	print("Z-index del botón: ", boton.z_index)
	
	# Forzar propiedades del botón para asegurar que funcione
	boton.disabled = false
	boton.visible = true
	boton.modulate = Color.WHITE
	
	print("Botón configurado correctamente")

func _on_boton_presionado():
	print("=== ¡¡¡BOTÓN PRESIONADO!!! ===")
	if girando:
		print("Ya está girando, ignorando...")
		return
	
	print("Iniciando rotación...")
	girando = true
	velocidad = randf_range(8.0, 15.0)
	temporizador.start(4.0)
	GlobalAudioManager.play_sfx(preload("res://mini_juegos-(2)/ruleta (mp3cut.net).mp3"))

	
	boton.disabled = true
	
	print("Giro iniciado con velocidad: ", velocidad)

func _process(delta):
	if girando and manecilla != null:
		manecilla.rotation += velocidad * delta
		
		# Mostrar progreso ocasionalmente
		if int(Time.get_ticks_msec() / 500) != int((Time.get_ticks_msec() - delta * 1000) / 500):
			print("Girando... Ángulo: ", rad_to_deg(manecilla.rotation), " grados")
		
		velocidad = lerp(velocidad, 0.0, 0.8 * delta)

func _on_temporizador_terminado():
	print("=== TEMPORIZADOR TERMINADO ===")
	girando = false
	boton.disabled = false
	_determinar_minijuego()

func _determinar_minijuego():
	print("Determinando minijuego...")
	
	var angulo = fmod(manecilla.rotation, TAU)
	if angulo < 0:
		angulo += TAU
	
	print("Ángulo final: ", rad_to_deg(angulo), " grados")
	
	var seccion = floor(angulo / (TAU/3))
	print("Sección calculada: ", seccion)
	
	match seccion:
		0.0:
			print("¡SELECCIONADO MINIJUEGO 1!")
			get_tree().change_scene_to_file("res://mini_juegos-(2)/escenas/Turtle mini-game/Turtle mini-game/water.tscn")
		1.0:
			print("¡SELECCIONADO MINIJUEGO 2!")
			get_tree().change_scene_to_file("res://mini_juegos-(2)/control.tscn")
		2.0:
			print("¡SELECCIONADO MINIJUEGO 3!")
			get_tree().change_scene_to_file("res://mini_juegos-(2)/catching.tscn")

# MÚLTIPLES FORMAS DE ACTIVAR LA RULETA PARA DEBUGGING
func _input(event):
	# Presiona ESPACIO para activar
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		print("ESPACIO PRESIONADO - Activando giro")
		_on_boton_presionado()
	
	# Presiona ENTER para activar
	if event is InputEventKey and event.pressed and event.keycode == KEY_ENTER:
		print("ENTER PRESIONADO - Activando giro")
		_on_boton_presionado()
	
	# Clic en cualquier parte de la pantalla
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("CLIC DETECTADO en posición: ", event.position)
		_on_boton_presionado()

# Función que se ejecuta automáticamente después de 3 segundos (para prueba)
func _on_auto_start_timer():
	print("AUTO-START: Iniciando giro automáticamente")
	_on_boton_presionado()

# Timer automático para prueba
func _ready_auto_test():
	var auto_timer = Timer.new()
	add_child(auto_timer)
	auto_timer.wait_time = 3.0
	auto_timer.one_shot = true
	auto_timer.timeout.connect(_on_auto_start_timer)
	auto_timer.start()
	print("Timer automático iniciado - la ruleta girará en 3 segundos")
