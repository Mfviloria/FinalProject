extends CharacterBody2D

class_name Player

@export var _move_speed = 300
@export var _jump_speed = 490
@onready var animated_sprite = $Sprite2D
var att = false
var is_facing_right = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var the_name: String
var lifes = 3
var motion =  Vector2()
func _physics_process(delta):
	jump(delta)
	move_x()
	flip()
	animations()
	animation()
	move_and_slide()

func process(delta) -> void:
	if Input.is_action_just_pressed("attack"):
		att = true
		animation()



func animation():
	if att:
		animated_sprite.play("attack")
	elif is_on_floor():
		if velocity.x != 0:
			animated_sprite.play("walk")
		else:
			animated_sprite.play("idle")
	else:
		animated_sprite.play("idle")
		
func jump(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -_jump_speed
	
	if not is_on_floor():
		velocity.y += gravity * delta

func flip():
	if (is_facing_right and velocity.x < 0) or (not is_facing_right and velocity.x > 0):
		animated_sprite.flip_h = not animated_sprite.flip_h
		is_facing_right = not is_facing_right

func move_x():
	var input_axis = Input.get_axis("move_left", "move_right")
	velocity.x = input_axis * _move_speed


func animations():
	animated_sprite.play("shutup")
	
func _on_mouse_exited() -> void:
	animated_sprite.play("shutdown")
	
func _loseLife(enemyposX):
	if position.x < enemyposX:
		motion.x = -200
		motion.y = -100
	if position.x > enemyposX:
		motion.x = 200
		motion.y = -100
	get_tree().reload_current_scene()
