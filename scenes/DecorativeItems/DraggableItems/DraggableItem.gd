extends Area2D

onready var timer: Timer = $Timer
onready var drag_component: Draggable = $Drag_n_Drop_component

var is_dragging
var last_position: Vector2

func _ready():
	connect("input_event", self, "_on_BaseItem_input_event")
	set_process(false)

func _on_BaseItem_input_event(_viewport, event, _shape_idx):
	is_dragging = drag_component.item_held_down(event)

	if is_dragging != null:
		if is_dragging:
			last_position = global_position
			set_process(true)
			timer.start()
		else:
			set_process(false)


func _process(delta):
	if timer.is_stopped():
		global_position = get_global_mouse_position()
