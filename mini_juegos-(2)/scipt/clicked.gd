extends Area2D
signal clicked

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("¡Carta clickeada!") # <-- AÑADE ESTO
			self.emit_signal("clicked")


		
