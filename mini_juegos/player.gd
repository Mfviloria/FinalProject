extends Area2D

var speed = 300

var velocity = Vector2()
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	print("Tamaño de pantalla: ", screen_size) # Para confirmar el tamaño

func _process(delta):
	velocity = Vector2.ZERO # Reinicia la velocidad para cada frame

	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		print("Presionando derecha, velocity.x: ", velocity.x)
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		print("Presionando izquierda, velocity.x: ", velocity.x) # ¡CLAVE para depurar!

	# Normaliza la velocidad si hay movimiento.
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		print("Velocity normalizada y con speed: ", velocity) # Ver el vector final

	position += velocity * delta

	position.x = clamp(position.x, -1,1900 - $Sprite2D.texture.get_width())
