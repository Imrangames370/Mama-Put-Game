extends Camera2D

export var zoom_in_limit : float = 0.5
export var zoom_out_limit : float = 2.0
export var zoom_speed  = 0.1

onready var drag_component: Draggable = $Drag_n_Drop_component

var is_dragging
var zoom_level  = 1.0
var drag_start_position

func _ready():
	set_process(false)
	current = true

func _input(event):
	if event.is_action_pressed("zoom_out", true):
		zoom_level += get_process_delta_time() * zoom_speed

	if event.is_action_pressed("zoom_in", true):
		zoom_level -= get_process_delta_time() * zoom_speed

	is_dragging = drag_component.item_held_down(event)

	# Validate to check for a null value
	if is_dragging == true:
		drag_start_position = event.position
		set_process(true)
	elif is_dragging == false:
		set_process(false)

	calculate_zoom()


func calculate_zoom() -> void:
	zoom = Vector2(zoom_level, zoom_level)
	zoom_level = clamp(zoom_level, zoom_in_limit, zoom_out_limit)


func _process(delta):
	var drag_delta = drag_start_position - get_viewport().get_mouse_position()
	offset += drag_delta / zoom
	drag_start_position = get_viewport().get_mouse_position()
