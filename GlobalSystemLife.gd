extends Node

signal health_changed(new_health)

var max_health := 4
var health := 4
var is_dead := false
var death_anim_played := false

func reset():
	health = max_health
	is_dead = false
	death_anim_played = false
	emit_signal("health_changed", health)

func take_damage(damage: int):
	GlobalAudioManager.play(preload("res://sonido_herido.mp3"))
	if is_dead:
		return
	health -= damage
	if health <= 0:
		health = 0
		is_dead = true
	emit_signal("health_changed", health)
	
func resetminigame():
	health = 2 
	is_dead = false
	death_anim_played = false
	emit_signal("health_changed", health)
