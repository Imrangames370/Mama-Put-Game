extends Camera2D

export var zoom_in_limit : float = 0.5
export var zoom_out_limit : float = 2.0
export var zoom_speed  = 0.1

onready var drag_component: Draggable

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
	
	# TODO: Continuos assignment of drag_start_position. Fix
	drag_start_position = event.position
	drag_component.item_held_down(event)

	calculate_zoom()


func calculate_zoom() -> void:
	zoom = Vector2(zoom_level, zoom_level)
	zoom_level = clamp(zoom_level, zoom_in_limit, zoom_out_limit)


func _process(delta):
	var drag_delta = drag_start_position - get_viewport().get_mouse_position()
	offset += drag_delta / zoom
	drag_start_position = get_viewport().get_mouse_position()


func _on_Drag_n_Drop_component_drag_began():
	set_process(true)


func _on_Drag_n_Drop_component_drag_ended():
	set_process(false)
