class_name Globals

static var camera : Camera2D
static var world : World
static var world_rect : Rect2 = Rect2(0,0,0,0)


static func get_camera():
	
	if camera : return camera
	


static func set_camera(new_camera):
	
	camera = new_camera
	


static func get_world_rect():
	
	return world_rect
	


static func get_world():
	
	if world : return world
	


static func set_world(new_world: World):
	
	world = new_world
	
	world_rect = Rect2(world.get_used_rect())
	world_rect.size *= world.scale.x
	
