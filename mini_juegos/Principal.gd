extends Node2D

@onready var cartaPrefab = preload("res://mini_juegos/carta.tscn")
@onready var tiempo = $tiempo

var carta_al_descubierto = null
var _cartas = []

const CANTIDAD_PARES := 3  # 3 pares = 6 cartas
var cantidad_carta := CANTIDAD_PARES * 2
var pares_encontrados: int = 0

func _ready() -> void:
	randomize()
	init_game()

func _columnas_para_cartas(carta: int) -> int:
	match carta:
		6:
			return 3
		_:
			return 2

func init_game():
	var columns: int = _columnas_para_cartas(cantidad_carta)
	var screen_width = get_viewport().get_visible_rect().size.x
	var screen_height = get_viewport().get_visible_rect().size.y
	var fila: int = ceil(float(cantidad_carta) / float(columns))

	var margin_horizontal = screen_width * 0.10
	var margin_vertical = screen_height * 0.13

	var available_width = screen_width - (2 * margin_horizontal)
	var available_height = screen_height - (2 * margin_vertical)

	var spacing_factor = 0.9
	var max_card_width = available_width / (columns * (1 + spacing_factor) - spacing_factor)
	var max_card_height = available_height / (fila * (1 + spacing_factor) - spacing_factor)

	var card_size = min(max_card_width, max_card_height)
	var spacing = card_size * spacing_factor

	var total_width = (card_size * columns) + (spacing * (columns - 1))
	var total_height = (card_size * fila) + (spacing * (fila - 1))
	var start_x = (screen_width - total_width) / 2
	var start_y = (screen_height - total_height) / 2

	# Crear las caras (2 de cada una)
	var caras: Array = []
	for i in range(CANTIDAD_PARES):
		var cara: String = "carta" + str(i + 1)
		caras.append(cara)
		caras.append(cara)

	caras.shuffle()

	# Crear e instanciar las cartas
	for i in range(cantidad_carta):
		var row = floor(i / columns)
		var col = i % columns

		var carta = cartaPrefab.instantiate()
		carta.add_to_group("carta")

		var pos_x = start_x + col * (card_size + spacing)
		var pos_y = start_y + row * (card_size + spacing)

		carta.global_position = Vector2(pos_x, pos_y)

		var scale_factor = card_size / 200.0
		carta.scale = Vector2(scale_factor, scale_factor)

		add_child(carta)
		carta.poner_cara(caras[i])

		# Animación de entrada
		carta.modulate.a = 0.0
		carta.scale = Vector2.ZERO

		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(carta, "modulate:a", 1.0, 0.4).set_delay(i * 0.08)
		tween.tween_property(carta, "scale", Vector2(scale_factor, scale_factor), 0.4).set_delay(i * 0.08).set_trans(Tween.TRANS_BACK)

		# Guardar y conectar
		_cartas.append(carta)
		carta.connect("clicked", Callable(self, "_on_carta_clicked"))

func _on_carta_clicked(carta):
	if carta.esta_volteado:
		return

	carta.flip()

	if carta_al_descubierto == null:
		carta_al_descubierto = carta
	else:
		for c in _cartas:
			if is_instance_valid(c):
				c.click.set_deferred("input_pickable", false)

		await get_tree().create_timer(1.0).timeout

		if carta.cara == carta_al_descubierto.cara:
			carta.queue_free()
			carta_al_descubierto.queue_free()

			pares_encontrados += 1

			if pares_encontrados == CANTIDAD_PARES:
				get_tree().change_scene_to_file("res://mini_juegos/gano.tscn")
		else:
			carta.reset()
			carta_al_descubierto.reset()

		carta_al_descubierto = null

		for c in _cartas:
			if is_instance_valid(c):
				c.click.set_deferred("input_pickable", true)
