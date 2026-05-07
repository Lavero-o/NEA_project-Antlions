class_name World
extends TileMapLayer

var tile_atlas = {
	'deep_water': Vector2i(2,0),
	'shallow_water': Vector2i(3,0),
	'sand': Vector2i(0,0),
	'dirt': Vector2i(4,0),
	'grass': Vector2i(1,0)
}

var noise_thresholds = {
	'deep_water': 0.1,
	'shallow_water': 0.2,
	'sand': 0.35,
	'dirt': 0.5,
	'grass': 1
}

signal world_ready

var nest_base_node = preload("res://Prefabs/Structures/nest_entity.tscn").instantiate()

@export var entity_node: Node2D
@export var world_width: int = 250
@export var world_height: int = 250
@export var world_noise: FastNoiseLite
@export var end_vinette: GradientTexture2D
@export var world_seed: int = -1
@export var starting_number_of_ants: int = 5
@export var test: Resource

var noise_image: Image
var end_gradient: Image

var used_rect: Rect2

func _ready() -> void:
	gen_world()
	Globals.set_world(self)
	
	var nest: Nest = random_spawn_entity(Enums.entity.NEST)
	
	for i in starting_number_of_ants:
		nest._spawn_ant(Enums.entity.ANT)
	
	emit_signal('world_ready')
	
	%CameraChar.position = nest.position
	print(get_viewport().get_camera_2d())

func spawn_entity(entity_type: Enums.entity, entity_position: Vector2) -> Entity:
	var entity = Globals.new_entity_by_type(entity_type)
	entity.position = entity_position
	return entity

func random_spawn_entity(entity_type: Enums.entity) -> Node:
	
	var cell_pos = get_used_cells_by_id(0,Vector2i(1,0)).pick_random()
	var pos = (Vector2(cell_pos) + (Vector2(tile_set.tile_size)/2)) * scale
	var entity = spawn_entity(entity_type, pos)
	return entity

func get_tile_on_noise(noise_val) -> String:
	var tile_to_return = ''
	for tile in noise_thresholds:
		tile_to_return = tile
		var threshold = noise_thresholds[tile]
		if noise_val <= threshold:
			break
	return tile_to_return

func get_noise_val(pos) -> float:
	var noise_val = noise_image.get_pixel(pos.x,pos.y).get_luminance()
	noise_val *= end_gradient.get_pixel(pos.x,pos.y).get_luminance()
	return noise_val

func gen_world(_seed = -1) -> void:
	if _seed == -1:
		_seed = randi()
	world_seed = _seed
	
	world_noise.seed =  world_seed
	noise_image = world_noise.get_image(world_width, world_height)
	end_vinette.width = world_width
	end_vinette.height = world_height
	end_gradient = end_vinette.get_image()
	
	for tile_y in range(0,world_height):
		for tile_x in range(0,world_width):
			var noise = get_noise_val(Vector2i(tile_x, tile_y))
			var tile = get_tile_on_noise(noise)
			var tile_atlas_cord = tile_atlas[tile]
			set_cell(Vector2i(tile_x, tile_y), 0, tile_atlas_cord)
	
	used_rect = Rect2(get_used_rect())

func is_land(_cell_pos: Vector2):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
