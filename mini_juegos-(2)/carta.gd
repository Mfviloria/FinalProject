extends Node2D

signal volteado(carta)
signal clicked(carta)

var esta_volteado: bool
var cara: String

@onready var Carta1 = $Carta1
@onready var Tapa = $Tapa
@onready var click = $clicked

func _ready() -> void:
	$anim.play("cubrir")
	click.connect("clicked", Callable(self, "_on_clicked"))  

func poner_cara(f: String):	
	cara = f
	Carta1.texture = load("res://mini_juegos-(2)/imagen/"+ cara + ".png")

func flip():
	print("¡Flip ejecutado!")
	if esta_volteado:
		return
	$anim.play("descubrir")
	esta_volteado = true
	emit_signal("volteado", self)

func reset():
	if !esta_volteado: return
	$anim.play("cubrir")
	esta_volteado = false
	emit_signal("volteado", self)

func _on_clicked():
	print("Se ejecutó _on_clicked")
	emit_signal("clicked", self)
	






	
	
	
	
