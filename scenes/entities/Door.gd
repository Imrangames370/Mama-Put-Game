# Cannot be tested independently if customer_scene not initialized
extends Node2D

onready var navigation_node : Navigation2D
onready var sprite : = $Sprite

export(float) var spawn_duration := 5.0
export var customer_scene: PackedScene

const DOOR_OPEN = preload("res://imgs/IMG_20230813_133901.JPG")
const DOOR_CLOSED = preload("res://imgs/IMG_20230813_133901.JPG")

var door_closed := true setget set_door_closed

func _ready():
	$Timer.wait_time = spawn_duration
	if get_tree().has_group("navigator"):
		navigation_node = get_tree().get_nodes_in_group("navigator")[0]

func _get_configuration_warning():
	return "Scene not Found. Please assign a value" if customer_scene == null else ""


func spawn_customer() -> void:
	# Spawn customer if timer is out and door is closed
	pass

func set_door_closed(value) -> void:
	door_closed = value
	sprite.texture = DOOR_CLOSED if door_closed else DOOR_OPEN # Update Door Image
