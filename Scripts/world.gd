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

@export var world_width = 500
@export var world_height = 500

@export var world_noise: FastNoiseLite
@export var end_vinette: GradientTexture2D

var noise_image: Image
var end_gradient: Image

var used_rect: Rect2

func _ready() -> void:
	world_noise.seed = randi()
	noise_image = world_noise.get_image(world_width, world_height)
	end_vinette.width = world_width
	end_vinette.height = world_height
	end_gradient = end_vinette.get_image()
	gen_world()

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

func gen_world() -> void:
	for tile_y in range(0,world_height):
		for tile_x in range(0,world_width):
			var noise = get_noise_val(Vector2i(tile_x, tile_y))
			var tile = get_tile_on_noise(noise)
			var tile_atlas_cord = tile_atlas[tile]
			set_cell(Vector2i(tile_x, tile_y), 0, tile_atlas_cord)
	
	used_rect = get_used_rect()

func is_land(cell_pos: Vector2):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
