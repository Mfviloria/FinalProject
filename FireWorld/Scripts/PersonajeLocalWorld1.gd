extends CharacterBody2D

var knockback_timer = 0.0
var knockback_force = Vector2.ZERO
@export var _move_speed = 300
@export var _jump_speed = 490
@export var speedaum = 900
@export var jumpspeedaum = 490
@onready var animated_sprite = $AnimatedSprite2D
var att = false
var is_facing_right = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var the_name: String
var hearts_list: Array[TextureRect]
var health = 4
var death = false

@export var attack = false

func _ready() -> void:
	var hearts_parents = $CanvasLayer/HBoxContainer
	for child in hearts_parents.get_children():
		hearts_list.append(child)
		
	GlobalSystemLife.connect("health_changed", Callable(self, "update_heart_display"))
	update_heart_display(GlobalSystemLife.health)

func take_damage(enemyposx, damage):
	if position.x < enemyposx:
		knockback_force = Vector2(-300, -130)
	else:
		knockback_force = Vector2(-300, -130)
	knockback_timer = 0.2
	GlobalSystemLife.take_damage(damage)
		
func update_heart_display(current_health: int):
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < current_health

func _physics_process(delta):
	jump(delta)
	if knockback_timer > 0:
		velocity = knockback_force
		knockback_timer -= delta
	else:
		move_x()
	flip()
	move_and_slide()
	animation()

func _process(delta):
	if Input.is_action_just_pressed("attack") and not att and not death:
		att = true

func atacar():
	animated_sprite.play("attack")
	await animated_sprite.animation_finished
	att = false
	animated_sprite.play("idle")
	
func animation():
	if GlobalSystemLife.is_dead:
		if not GlobalSystemLife.death_anim_played:
			animated_sprite.play("dead")
			GlobalSystemLife.death_anim_played = true
			await animated_sprite.animation_finished
			GlobalSceneManager.change_to_scene("res://GameOver.tscn")
		return

	if att:
		atacar()
		return

	if is_on_floor():
		if velocity.x != 0:
			animated_sprite.play("walk")
		else:
			animated_sprite.play("idle")
	else:
		animated_sprite.play("idle")

func revivir():
	GlobalSystemLife.reset()
	get_tree().reload_current_scene()

func jump(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		GlobalAudioManager.play(preload("res://audio_up_.mp3"))
		velocity.y = -_jump_speed
	
	if not is_on_floor():
		velocity.y += gravity * delta

func flip():
	if knockback_timer > 0 or att or death:
		return
	var input_axis = Input.get_axis("move_left", "move_right")
	if input_axis < 0 and is_facing_right:
		animated_sprite.flip_h = true
		is_facing_right = false
		GlobalAudioManager.play(preload("res://audio_left_.mp3"))
	elif input_axis > 0 and not is_facing_right:
		GlobalAudioManager.play(preload("res://audio_right_.mp3"))
		animated_sprite.flip_h = false
		is_facing_right = true

func move_x():
	var input_axis = Input.get_axis("move_left", "move_right")
	velocity.x = input_axis * _move_speed

func aumentvelo():
	_move_speed = speedaum
	_jump_speed = 490
	
func normalvelo():
	_move_speed = 300
	_jump_speed = 490
