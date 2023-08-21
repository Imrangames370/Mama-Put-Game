extends Actor

var path := PoolVector2Array() setget set_path

func set_path(value: PoolVector2Array) -> void:
	if value.size() == 0:
		return

	path = value
