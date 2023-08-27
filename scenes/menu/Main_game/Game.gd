extends Node2D

onready var nav = $Navigation2D
onready var p1 = $Y_Sort/Player3

func test_load_nav():
	var _path = nav.get_node("Player4/NavigationAgent2D").get_nav_path()
#	var s = nav.get_simple_path(p1.position, $Y_Sort/Player4.position)
#	print(s)
	
	draw_line_from_vecPool_arr(_path, $Line2D)


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


func _ready():
#	test_load_nav()
	pass


func _process(delta):
	test_load_nav()
	pass
