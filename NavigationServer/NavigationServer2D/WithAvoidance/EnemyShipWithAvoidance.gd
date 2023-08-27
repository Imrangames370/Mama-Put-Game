extends KinematicBody2D

export var path_to_player := NodePath()

var _velocity := Vector2.ZERO

onready var _agent: NavigationAgent2D = $NavigationAgent2D
onready var _timer := $Timer
onready var _sprite := $Sprite

onready var _player := get_node(path_to_player)

onready var push = $"../../push_Text_Notification"

func _ready() -> void:
	_timer.connect("timeout", self, "_update_pathfinding")
	_agent.connect("velocity_computed", self, "move")

	if "avoidance_enabled" in $NavigationAgent2D:
#		get_parent().modulate = Color.rebeccapurple
#		$NavigationAgent2D.avoidance_enabled = true
		pass

func conv_poolVectArr_to_position_of(arr:PoolVector2Array, pos:Vector2):
	for i in arr.size():
		arr.set(i, arr[i]+pos)
	return arr

func _physics_process(delta: float) -> void:
	var avoid_poly = $"../../Avoid/NavigationPolygonInstance"
	var nav_path_poly = $"../../Nav_Path/NavigationPolygonInstance"
	
	# draw path find
	draw_line_from_vecPool_arr($NavigationAgent2D.get_nav_path(), get_parent().get_node("Line2D"), false)
	
	var excluded = Geometry.clip_polygons_2d(nav_path_poly.navpoly.get_outline(0), conv_poolVectArr_to_position_of(avoid_poly.navpoly.get_outline(0), avoid_poly.position))
#	var excluded = Geometry.clip_polygons_2d(nav_path_poly.navpoly.get_outline(0), conv_poolVectArr_to_position_of(avoid_poly.navpoly.get_outline(0), avoid_poly.position))
#	var excluded = [nav_path_poly.navpoly.get_outline(0), nav_path_poly.navpoly.get_outline(1)]

#	prints(excluded.size(), excluded)

	for i in excluded.size():
		draw_line_from_vecPool_arr(excluded[i], get_parent().get_parent().get_node("Line2D"+str(i)))
	if excluded.size() == 0:
		for v in get_parent().get_parent().get_children():
			if v is Line2D:
				v.clear_points()
				pass
	
	
#	prints(nav_path_poly.navpoly.get_polygon_count(), nav_path_poly.navpoly.get_outline_count(), nav_path_poly.navpoly.get_vertices().size())
	
	var polygon = NavigationPolygon.new()
	var polygon2 = NavigationPolygon.new()
	
	var union_avoid_poly : Array = [$"../../Avoid".get_child(0).navpoly.get_outline(0)]
	
	# add poly point of the map main zone
	polygon.add_outline(excluded[0])
	polygon.make_polygons_from_outlines()
	
	
	for i in $"../../Avoid/NavigationPolygonInstance2".navpoly.get_polygon_count():
		break
		var v
#		v = Geometry.clip_polygons_2d(nav_path_poly.navpoly.get_outline(0), conv_poolVectArr_to_position_of($"../../Avoid/NavigationPolygonInstance2".navpoly.get_outline(i), $"../../Avoid/NavigationPolygonInstance2".position))
		v =  conv_poolVectArr_to_position_of($"../../Avoid/NavigationPolygonInstance2".navpoly.get_outline(i), $"../../Avoid/NavigationPolygonInstance2".position)
		var outline2 = v
		polygon.add_outline(outline2)
		polygon.make_polygons_from_outlines()
	
	for v in excluded: 
		break
		var outline = v
		polygon.add_outline(outline)
		polygon.make_polygons_from_outlines()

#	$"../NorthRoomUnlockedPolygon".navpoly = polygon
#	$"../../Mini_Map".navpoly = polygon

	prints(polygon.get_outline_count(), polygon.get_polygon_count())


	var merged_match_array = []
	for i in $"../../Avoid".get_child_count():
		var v = $"../../Avoid".get_child(i)
		var check
		var merge_match = [conv_poolVectArr_to_position_of(     v.navpoly.get_outline(0),       v.position)]
		
		for j in $"../../Avoid".get_child_count():
			var vv = $"../../Avoid".get_child(j)
			check =  Geometry.merge_polygons_2d(merge_match[0], conv_poolVectArr_to_position_of(vv.navpoly.get_outline(0), vv.position))
			
			if check.size() != 1:
				continue
				pass
			else:
				if i == 1:
					draw_line_from_vecPool_arr(check[0], get_parent().get_parent().get_node("Line2D4"))
#					push.push_message("drawning")
					pass
				
				merge_match = check
				
				if j == $"../../Avoid".get_child_count()-1:
					#merge to array
					merged_match_array.insert(i, merge_match[0])
					pass
	
	for i in merged_match_array.size():
#		draw_line_from_vecPool_arr(merged_match_array[i], get_parent().get_parent().get_node("Line2D4"+str(i)))
		if i == 0:
			pass
			polygon.add_outline(merged_match_array[i])
			polygon.make_polygons_from_outlines()


#	draw_line_from_vecPool_arr(polygon.get_outline(0), get_parent().get_parent().get_node("Line2D5"))
	
	
	$"../NorthRoomUnlockedPolygon".navpoly = polygon
	$"../../Mini_Map".navpoly = polygon
	



	if _agent.is_navigation_finished():
		return

	var target_global_position := _agent.get_next_location()
	var direction := global_position.direction_to(target_global_position)
	var desired_velocity := direction * _agent.max_speed
	var steering := (desired_velocity - _velocity) * delta * 4.0
	_velocity += steering
	_agent.set_velocity(_velocity)


func move(velocity: Vector2) -> void:
	_velocity = move_and_slide(velocity)
	_sprite.rotation = lerp_angle(_sprite.rotation, velocity.angle(), 10.0 * get_physics_process_delta_time())
	

func _update_pathfinding() -> void:
	_agent.set_target_location(_player.global_position)


func draw_line_from_vecPool_arr(pool_vec_arr:PoolVector2Array, line:Line2D, conv_to_poly:bool=true):
	for i in pool_vec_arr.size():
		if line.points.size() < pool_vec_arr.size():
			line.add_point(Vector2.ZERO, line.points.size())
		elif line.points.size() > pool_vec_arr.size():
			line.remove_point(line.points.size()-1)
		
		if line.points.size() <= pool_vec_arr.size():
			line.points[i] = pool_vec_arr[i]
		
		if i == pool_vec_arr.size()-1 and conv_to_poly:
			line.add_point(pool_vec_arr[0], line.points.size())
	
	if pool_vec_arr.size() == 0:
		line.clear_points()
