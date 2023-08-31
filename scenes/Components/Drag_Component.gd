extends Node
class_name Draggable

# Return a null value if is not mousebutton
func item_held_down(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				return true

			elif not event.pressed:
				return false
