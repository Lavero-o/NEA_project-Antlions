extends Node


var camera : Camera2D
var world : World
var world_rect : Rect2 = Rect2(0,0,0,0)


func screen_to_global(position: Vector2):
	if not camera : return
	print(position)
	print(get_viewport().canvas_transform.origin)
	print(camera.zoom)
	return (position + get_viewport().canvas_transform.origin*-1) / get_viewport().get_camera_2d().zoom


func get_camera():
	if camera : return camera


func set_camera(new_camera):
	camera = new_camera


func get_world_rect():
	return world_rect


func get_world():
	if world : return world


func set_world(new_world: World):
	
	world = new_world
	
	world_rect = Rect2(world.get_used_rect())
	world_rect.size *= world.scale.x
