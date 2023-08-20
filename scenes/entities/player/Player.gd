extends KinematicBody2D

var click_position = Vector2.ZERO
var is_dragging = false
var press_and_release = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.material = $Sprite.material.duplicate()


func _process(delta):
	update()
	
	if Input.is_action_just_pressed("mouse_click") and press_and_release:
#		position = get_global_mouse_position()
		pass
	if Input.is_action_just_pressed("reload_scene"):
		get_tree().reload_current_scene()
	
	if is_dragging:
#		print(press_and_release)
		$Sprite.material.set_shader_param("width", 0.9)
		$Sprite.material.set_shader_param("outline_color", Color.white)
	else:
#		print(press_and_release)
		$Sprite.material.set_shader_param("width", 0.0)
		$Sprite.material.set_shader_param("outline_color", Color.black)


func _input(event):
	if event is InputEventMouseMotion and is_dragging:
#	if event is InputEventMouse and is_dragging:
#	if event is InputEventMouse and is_dragging:
		global_position = get_global_mouse_position() + ((global_position)-to_global(click_position))


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed():
				click_position = to_local(event.position)
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
