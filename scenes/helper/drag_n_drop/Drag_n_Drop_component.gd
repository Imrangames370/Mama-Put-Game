extends Node


onready var area_2d = get_parent().get_node("Area2D")
onready var area_2d_col = get_parent().get_node("Area2D/CollisionShape2D")
onready var the_parent = get_parent()

var click_position = Vector2.ZERO
var is_dragging = false
var press_and_release = false 

# Called when the node enters the scene tree for the first time.
func _ready():
#	$Sprite.material = $Sprite.material.duplicate()
	area_2d.connect("input_event", self, "_on_Area2D_input_event")
	pass


func _input(event):
	if event is InputEventMouseMotion and is_dragging:
#	if event is InputEventMouse and is_dragging:
#	if event is InputEventMouse and is_dragging:
		the_parent.global_position = the_parent.get_global_mouse_position() + ((the_parent.global_position)-the_parent.to_global(click_position))


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed():
				click_position = the_parent.to_local(event.position)
				print(the_parent.get_global_mouse_position(), event.position)
				is_dragging = true
			else:
				
				if is_dragging:
					press_and_release = true
				else:
					press_and_release = false
					
				is_dragging = false

func _draw():
	# debug
#	draw_circle($CollisionShape2D.position, 120, Color.red)
#	draw_circle((click_position), 60, Color.blue)
	pass
