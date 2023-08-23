#Tested Indepently but will not Navigate
extends Actor

var path := PoolVector2Array() setget set_path
var navigation_node : Navigation2D
var target_position

func set_path(value: PoolVector2Array) -> void:
	if value.size() == 0:
		return

	path = value
	path.remove(0)

func create_path() -> void:
	if navigation_node != null:
		path = navigation_node.get_simple_path(global_position, target_position, false)
