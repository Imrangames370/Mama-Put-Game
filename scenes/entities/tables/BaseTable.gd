extends Node

onready var available_area := $AvailableAreas

func table_free():
	for child in available_area:
		if not child.is_filled():
			return true
	return false
