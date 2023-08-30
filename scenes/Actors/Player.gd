extends KinematicBody2D

var click_position = Vector2.ZERO
var is_dragging = false
var press_and_release = false 



# NAVIGATION STUFF:
var new_velocity = Vector2.ZERO
var movement_speed = 300.0
var movement_target_position = Vector2(460, 180)

onready var navigation_agent = $NavigationAgent2D 


func _ready():
	$Sprite.material = $Sprite.material.duplicate()
	
	#### NAVIGATION STUFF:
	navigation_agent.path_max_distance = 4.0
	navigation_agent.target_desired_distance = 14.0
	
	call_deferred("actor_setup")

func actor_setup():
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "physics_frame")
	set_movement_target(movement_target_position)

func set_movement_target(movement_target):
	navigation_agent.set_target_location(movement_target)

func update_nav():
	if navigation_agent.is_navigation_finished() or is_dragging:
		return
		

	var current_agent_position = global_position
	var next_path_position = navigation_agent.get_next_location()
	
	var new_velocity = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * movement_speed
	
	navigation_agent.set_velocity(new_velocity)
	
#	move_and_slide(new_velocity)

#	prints(new_velocity, navigation_agent.get_nav_path_index(), "end")
#	print(navigation_agent.get_nav_path())


func _physics_process(delta):
	update_nav()
	
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

	# movement_target_position
	draw_circle(to_local(movement_target_position), 30, Color.green)
	pass


func _on_NavigationAgent2D_velocity_computed(safe_velocity):
	new_velocity = move_and_slide(safe_velocity)


func _on_Timer_timeout():
	navigation_agent.set_target_location(movement_target_position)
	pass
