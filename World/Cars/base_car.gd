extends Sprite

# Might be changed for car to pick a random texture

export var car_speed : float = 40.0

onready var path_follow = get_parent()

func _ready():
	if not path_follow is PathFollow2D:
		set_process(false)

func _process(delta):
	path_follow.set_offset(path_follow.get_offset() + car_speed * delta)
