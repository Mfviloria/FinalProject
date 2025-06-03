extends Node2D

@export var lluvia_scene: PackedScene
@onready var spawn_timer = $SpawnTimer
@onready var war = $CanvasLayer/warning

func _ready() -> void:
	if war == null:
		print("Error: warning_image no encontrado")
		return
	
	war.visible = false
	_activate_sierras()
	# Configurar el timer inicial
	spawn_timer.wait_time = randf_range(20.0, 40.0)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	await get_tree().create_timer(10.0).timeout

	
	# Iniciar la primera lluvia
	start_warning_and_spawn()

func _activate_sierras():
	for i in range(1, 33):
		var sierra_node = get_node_or_null("ParallaxLayer2/sierra%s" % i)
		if sierra_node:
			sierra_node.play("default")

func _on_spawn_timer_timeout():
	start_warning_and_spawn()

func _on_caída_body_entered(body: CharacterBody2D) -> void:
	get_tree().reload_current_scene()

func start_warning_and_spawn() -> void:
	war.visible = true
	await get_tree().create_timer(8.0).timeout
	war.visible = false
	spawn_rain()

func spawn_rain() -> void:
	if not lluvia_scene:
		return
	var nueva_lluvia = lluvia_scene.instantiate()
	var spawn_y = randf_range(50.0, 500.0)
	nueva_lluvia.position = Vector2(-200, spawn_y)
	add_child(nueva_lluvia)
	
	# Programar la siguiente lluvia
	spawn_timer.wait_time = randf_range(30.0, 50.0)
	spawn_timer.start()
	


func _on_button_2_pressed() -> void:
	$CanvasLayer/Sprite2D.visible = false 
	$CanvasLayer/Button2.visible = false 
