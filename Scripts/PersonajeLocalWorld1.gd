extends CharacterBody2D

@export var _move_speed = 300
@export var _jump_speed = 490
@onready var animated_sprite = $AnimatedSprite2D
var att = false
var is_facing_right = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var the_name: String
var hearts_list: Array[TextureRect]
var health = 4
var death = false
var death_anim_played = false
@export var attack = false

func _ready() -> void:
	var hearts_parents = $CanvasLayer/HBoxContainer
	for child in hearts_parents.get_children():
		hearts_list.append(child)
	print(hearts_list)
	
func take_damage():
	if health > 0:
		health -= 1
		update_heart_display()
		
func update_heart_display():
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < health
	if health <= 0:
		death = true

func _physics_process(delta):
	jump(delta)
	move_x()
	flip()
	move_and_slide()
	animation()

func _process(delta):
	if Input.is_action_just_pressed("attack") and not att and not death :
		att = true

func atacar():
	animated_sprite.play("attack")
	await animated_sprite.animation_finished
	att = false
	animated_sprite.play("idle")
	
	
func animation():
	if death:
		if not death_anim_played:
			animated_sprite.play("dead")
			death_anim_played = true
			await animated_sprite.animation_finished
			revivir()
		return  # Si murió, no hacer nada más

	if att:
		atacar()
		return

	if is_on_floor():
		if velocity.x != 0:
			animated_sprite.play("walk")
		else:
			animated_sprite.play("idle")
	else:
		animated_sprite.play("jump")

func revivir():
	health = 4
	update_heart_display()
	get_tree().change_scene_to_file("res://scenes/world_fire.tscn")
	

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
