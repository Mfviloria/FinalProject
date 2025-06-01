extends Node2D

var max_scale = 4.0
var grow_speed = 6.0
var growing 
var base_y = 0.0 

func _ready() -> void:
	base_y = $Node2D/AnimatedSprite2D.position.y
	$Node2D/AnimatedSprite2D.play("Fire")
	

func _process(delta):
	if growing:
		var sprite = $Node2D/AnimatedSprite2D
		if sprite.scale.y < max_scale:
			var frame_texture = sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame)
			var height = frame_texture.get_height()

			var grow_step = delta * grow_speed
			sprite.scale.y += grow_step
			sprite.position.y -= (grow_step * height / 2)

func _on_area_2d_2_body_entered(body: CharacterBody2D) -> void:
	growing = true
