extends Node2D


export(PackedScene) var resource 
export var wait_time = 1.0
export var use_timer = false

#resource_prefab = load(resource)
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = wait_time
#	$Timer.autostart = true
	if not use_timer:
		spawn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func spawn():
	var resource_instance = resource.instance()
	resource_instance.position = position
#	get_parent().call_deferred("add_child", resource_instance)
	get_parent().add_child(resource_instance)


func _on_Timer_timeout():
	if use_timer:
		spawn()
	

