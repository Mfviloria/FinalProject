extends CharacterBody2D

@export var speed = 100
@export var gravity = 980
var direction = Vector2(1, 1).normalized()
var has_landed = false
var explosion_spawned = false 
var falling = false

func _ready():
	$FallingTree.stop()
	$AnimatedSprite2D.visible = false
	$AnimatedSprite2D2.visible = false 

func _physics_process(delta):
	if not falling:
		return  # No se mueve hasta que lo actives
	elif has_landed:
		if not explosion_spawned:
			spawn_explosion()
			explosion_spawned = true
		return

	velocity = direction * speed
	velocity.y += gravity * delta
	move_and_slide()


func spawn_explosion():
	$FallingTree.visible = false
	$AnimatedSprite2D.visible=true
	$AnimatedSprite2D.play("explosion")

func _on_area_2d_area_entered(area: Area2D) -> void:
	has_landed = true

func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.visible = false
	$FallingTree.visible = false
	$AnimatedSprite2D2.visible = true
	$AnimatedSprite2D2.play("Fire")

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	body.take_damage(position.x)


func _on_area_2d_2_body_entered(body: CharacterBody2D) -> void:
	$FallingTree.play("Fallingtree")
	falling = true
	$AnimatedSprite2D.visible = false
	$AnimatedSprite2D2.visible = false
