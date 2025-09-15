class_name Industrial extends "res://World.gd"

@export var lluvia_scene: PackedScene
@onready var spawn_timer = $SpawnTimer
@onready var war = $CanvasLayer/warning

func _ready() -> void:
	$CanvasLayer/previous.visible = false
	$CanvasLayer/Sprite2D4.visible = false
	$CanvasLayer/Sprite2D2.visible = false
	$CanvasLayer/Sprite2D3.visible = false
	if war == null:
		return
	
	war.visible = false
	_activate_sierras()
	spawn_timer.wait_time = randf_range(20.0, 40.0)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	await get_tree().create_timer(8.0).timeout
	start_warning_and_spawn()

func _activate_sierras():
	for i in range(1, 33):
		var sierra_node = get_node_or_null("ParallaxLayer2/sierra%s" % i)
		if sierra_node:
			sierra_node.play("default")
			
func _on_spawn_timer_timeout():
	start_warning_and_spawn()
	
func start_warning_and_spawn() -> void:
	war.visible = true
	await get_tree().create_timer(5.0).timeout
	war.visible = false
	spawn_rain()

func spawn_rain() -> void:
	if not lluvia_scene:
		return
	var nueva_lluvia = lluvia_scene.instantiate()
	var spawn_y = randf_range(50.0, 500.0)
	nueva_lluvia.position = Vector2(-200, spawn_y)
	add_child(nueva_lluvia)
	spawn_timer.wait_time = randf_range(30.0, 50.0)
	spawn_timer.start()
	
func _on_button_2_pressed() -> void:
	$CanvasLayer/next.visible = false
	$CanvasLayer/Button2.visible = false
	$CanvasLayer/Sprite2D.visible = false 
	$CanvasLayer/Button2.visible = false 

func _on_button_pressed() -> void:
	$CanvasLayer/Pausa.visible = true
	
func _on_caída_body_entered(body: CharacterBody2D) -> void:
	GlobalAudioManager.play_sfx(preload("res://Falling.mp3"))
	
	get_tree().reload_current_scene()


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	
	$CanvasLayer/Button.visible = false
	GlobalAudioManager.stop_specific_music(preload("res://rain_sound.wav"))
	$IndustrialCrystal.visible = false
	GlobalAudioManager.play_sfx(preload("res://video-game-bonus-323603.mp3"))
	await get_tree().create_timer(1.49).timeout
	GlobalAudioManager.play_sfx(preload("res://game-level-complete-143022.mp3"))
	$CanvasLayer/Sprite2D2.visible = true
	await get_tree().create_timer(8.0).timeout
	GlobalAudioManager.play_sfx(preload("res://FinalWin.mp3"))
	$CanvasLayer/Sprite2D3.visible = true

func _on_next_pressed() -> void:
	$CanvasLayer/Sprite2D.visible= false
	$CanvasLayer/Sprite2D4.visible = true
	$CanvasLayer/next.visible = false
	$CanvasLayer/previous.visible = true
	$CanvasLayer/Button2.visible = true
	
func _on_button_3_pressed() -> void:
	$CanvasLayer/Button2.visible = true
	$CanvasLayer/Sprite2D.visible= true
	$CanvasLayer/Sprite2D4.visible = false
	$CanvasLayer/next.visible = true
	$CanvasLayer/previous.visible = false
