extends Node2D


enum _TYPE {Tray ,Chair, }
export(_TYPE) var _type = _TYPE.Tray

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	for body in $Area2D.get_overlapping_areas():
		if body.get_parent().is_in_group((_TYPE.keys()[_type])):

			for v in body.get_parent().get_children():
				if v.is_in_group("Ghost_component"):
					v.move_ghost_to(get_parent(), global_position)
					
				if v.is_in_group("Drag_n_Drop_component"):
					if not v.is_dragging:
						print("Yep")
						body.get_parent().position = position
						pass
						
#		body.get_parent().position = position
