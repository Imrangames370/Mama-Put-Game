extends Area2D

onready var drag_component: Draggable = $Drag_n_Drop_component

func _ready():
	connect("input_event", self, "_on_BaseItem_input_event")
	drag_component.connect("drag_began", self, "_on_Drag_n_Drop_component_drag_began")
	drag_component.connect("drag_ended", self, "_on_Drag_n_Drop_component_drag_ended")
	set_process(false)

func _on_BaseItem_input_event(_viewport, event, _shape_idx):
	drag_component.item_held_down(event)


func _on_Drag_n_Drop_component_drag_began():
	set_process(true)

func _on_Drag_n_Drop_component_drag_ended():
	set_process(false)

func _process(delta):
	global_position = get_global_mouse_position()
	
