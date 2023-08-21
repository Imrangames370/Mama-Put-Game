extends Node

onready var area_2d = get_parent().get_node("Area2D")
onready var area_2d_col = get_parent().get_node("Area2D/CollisionShape2D")
onready var the_parent = get_parent()

var click_position = Vector2.ZERO
var is_dragging = false
var press_and_release = false 

func _ready():
	area_2d.connect("input_event", self, "_on_Area2D_input_event")


func _input(event):
	if event is InputEventMouseMotion and is_dragging:
		the_parent.global_position = the_parent.get_global_mouse_position() + ((the_parent.global_position)-the_parent.to_global(click_position))

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
			if event.is_pressed():
				click_position = the_parent.to_local(event.position)
				is_dragging = true
			else:
				if is_dragging:
					press_and_release = true
				else:
					press_and_release = false
					
				is_dragging = false
