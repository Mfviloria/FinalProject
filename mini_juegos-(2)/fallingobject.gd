extends Area2D

func _process(delta: float) -> void:
	position.y += randf_range(0,5)

func _on_area_entered(area: Area2D) -> void:
		if area.name == "Player":
			get_tree().root.get_node("Catching").update_score(+1)
			queue_free()
