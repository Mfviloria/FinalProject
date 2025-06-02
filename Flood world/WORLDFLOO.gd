extends Node2D

var petróleo1
var petróleo2
var petróleo3
var petróleo4
var petróleo5
var petróleo6
var petróleo7



func _ready():
	petróleo1 = $ParallaxBackground/ParallaxLayer2/petróleo1
	petróleo2 = $ParallaxBackground/ParallaxLayer2/petróleo2
	petróleo3 = $ParallaxBackground/ParallaxLayer2/petróleo3
	petróleo4 = $ParallaxBackground/ParallaxLayer2/petróleo4
	petróleo5 = $ParallaxBackground/ParallaxLayer2/petróleo5
	petróleo6 = $ParallaxBackground/ParallaxLayer2/petróleo6
	petróleo7 = $ParallaxBackground/ParallaxLayer2/petróleo7
	
	
	
	petróleo1.play("Fire")
	petróleo2.play("Fire")
	petróleo3.play("Fire")
	petróleo4.play("Fire")
	petróleo5.play("Fire")
	petróleo6.play("Fire")
	petróleo7.play("Fire")
	
func _on_caída_body_entered(body: CharacterBody2D) -> void:
	get_tree().reload_current_scene()
