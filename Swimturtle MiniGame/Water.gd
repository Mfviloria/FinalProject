extends Node2D

@export var Trashscene: PackedScene
@export var TrashsceneLonger : PackedScene
@export var plastic1: PackedScene
@export var plastic2 : PackedScene
var game_running: bool
var game_over: bool
var scroll
var score
const ScrollSpeed: int = 4
var screen_size : Vector2i
var groundHeight: int
var pipes: Array
var plastics: Array
const PipeDelay: int = 100
const PipeRange: int = 200

func _ready():
	screen_size = get_viewport_rect().size
	groundHeight = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()
	
func new_game():
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	pipes.clear()
	plastics.clear()
	generatePlastic()
	generateTrash()
	$CharacterBody2D.reset()

func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $CharacterBody2D.flying:
						$CharacterBody2D.flap()
						check_top()
func start_game():
	game_running = true
	$CharacterBody2D.flying = true
	$CharacterBody2D.flap()
	$Trashtimer.start()
	
func _process(delta):
	if game_running:
		scroll += ScrollSpeed *delta
		if scroll >= screen_size.x:
			scroll = 0
		$Ground.position.x = -scroll*12
		for pipe in pipes:
			pipe.position.x -= ScrollSpeed
		for plast in plastics:
			plast.position.x -= ScrollSpeed
	if score == 20:
		#mostrar casa
		win()
		
func win():
	$Trashtimer.stop()
	game_running = false
	get_tree().change_scene_to_file("res://Swimturtle MiniGame/WIN.tscn")
	
	


func _on_trashtimer_timeout() -> void:
	generateTrash()
	generatePlastic()
	
func generateTrash():
	var trash
	if randi() % 2 == 0:
		trash = Trashscene.instantiate()
	else:
		trash = TrashsceneLonger.instantiate()
	var start_x = screen_size.x + PipeDelay
	var y_base = screen_size.y - groundHeight 
	trash.position = Vector2(start_x, y_base+400)
	trash.hit.connect(trash_hit)
	trash.core.connect(scored)
	add_child(trash)
	pipes.append(trash)
	
func scored():
	score +=1
	$Label.text = "SCORE: " + str(score)
	
func generatePlastic():
	var plastic
	if randi() % 2 == 0:
		plastic = plastic1.instantiate()
	else:
		plastic = plastic2.instantiate()
		
	var start_x = screen_size.x + PipeDelay
	var y_base = screen_size.y - groundHeight 
	plastic.position = Vector2(start_x, y_base+ randi_range(130, 200))
	plastic.hit.connect(trash_hit)
	add_child(plastic)
	plastics.append(plastic)
	
	
func check_top():
	if $CharacterBody2D.position.y < -290:
		$CharacterBody2D.falling = true
		stop_game()
		
func stop_game():
	$Trashtimer.stop()
	$CharacterBody2D.flying = false
	game_running = false
	game_over = true
	


func trash_hit():
	$CharacterBody2D.falling = true
	stop_game()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Swimturtle MiniGame/LOse.tscn")
