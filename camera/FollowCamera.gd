extends Camera2D

export var zoom_in_limit : float = 0.5
export var zoom_out_limit : float = 2.0
export var zoom_speed  = 0.1

var zoom_level  = 1.0

func _ready():
	current = true

# Android Screen test control
#func _input(event):
#	if event is InputEventScreenDrag:
#		if event.index == 0 && event.is_action("pinch"):
#			zoom_level += event.delta.x * zoom_speed
#			zoom_level = clamp(zoom_level, 0.5, 2.0)
#			zoom = zoom_level

func _input(event):
	if event.is_action_pressed("zoom_out", true):
		zoom_level += get_process_delta_time() * zoom_speed

	if event.is_action_pressed("zoom_in", true):
		zoom_level -= get_process_delta_time() * zoom_speed

	zoom = Vector2(zoom_level, zoom_level)
	zoom_level = clamp(zoom_level, zoom_in_limit, zoom_out_limit)
