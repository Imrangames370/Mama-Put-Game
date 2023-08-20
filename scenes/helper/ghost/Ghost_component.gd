extends Node2D

onready var the_world = get_parent().get_parent()


var set_to_pos = Vector2.ZERO
var magnet_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
#	yield(get_tree(), "idle_frame")
	for v in get_parent().get_children():
		var _copy = v.duplicate(true)
#		var _copy = v.duplicate()
		if "modulate" in _copy:
			_copy.modulate = Color.red
			_copy.modulate.a = 0.18
		add_child(_copy)


func move_ghost_to(parent, _pos):
	global_position = (_pos)
	magnet_active = true
	pass
	


func _process(delta):
	if not magnet_active:
		self.hide()
	else:
		self.show()
	magnet_active = false
