extends HSlider

func _on_VolumeSlider_mouse_exited():
	release_focus()

func update_volume_value(_value) -> void:
	self.value = _value
