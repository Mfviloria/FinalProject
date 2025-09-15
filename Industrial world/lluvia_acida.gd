extends Node2D

@export var speed: float = 300.0
@export var world_width: float = 43595.0
@export var damage_amount: int = 2
@export var damage_interval: float = 1.0
@export var detection_width: float = 150.0  # Ancho de detección
@export var detection_height: float = 300.0  # Alto de detección

var damage_timer: float = 0.0
var player = null

func _ready():
	add_to_group("Lluvia")
	$lluvia.play("default")
	GlobalAudioManager.play_music(preload("res://rain_sound.wav"))

func _physics_process(delta):
	# Mover la lluvia
	position.x += speed * delta
	
	# Buscar jugador si no lo tenemos
	if player == null:
		var players = get_tree().get_nodes_in_group("Player")
		if players.size() > 0:
			player = players[0]
	
	# Si tenemos jugador, verificar distancia
	if player != null and is_instance_valid(player):
		var player_pos = player.global_position
		var rain_pos = global_position
		
		# Verificar si el jugador está dentro del área de la lluvia
		var x_distance = abs(player_pos.x - rain_pos.x)
		var y_distance = abs(player_pos.y - rain_pos.y)
		
		if x_distance < detection_width and y_distance < detection_height:
			damage_timer -= delta
			
			if damage_timer <= 0:
				player.take_damage(global_position.x, damage_amount)
				damage_timer = damage_interval
	
	# Destruir al salir del mundo
	if position.x > world_width + 200:
		queue_free()
