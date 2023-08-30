extends Node
class_name Draggable

signal drag_began
signal drag_ended

func item_held_down(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				emit_signal("drag_began")

			elif not event.pressed:
				emit_signal("drag_ended")
