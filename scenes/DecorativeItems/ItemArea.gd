extends Position2D

var area_filled := false setget set_area_filled

func is_filled() -> bool:
	return area_filled

func set_area_filled(value) -> void:
	area_filled = value
