extends Structure
class_name Nest

@export_group('Nest properties')
@export var queen_cap: int = 1
@export var ant_cap: int = 10
@export var food_cap: int = 30
@export var inv_cap: int = 20

#temporary
#var ant_base_node = preload("res://Prefabs/_Fundamentals/ant.tscn")

var worker_ant_scene: PackedScene
var scout_ant_scene: PackedScene
var fighter_ant_scene: PackedScene


var queens: Array
var ants: Array
var food: int


func _spawn_ant(type: Enums.entity):
	
	var min_range = 35
	var max_range = 50
	
	var ant_position = Vector2.UP.rotated(randf()*2*PI) * randf_range(min_range,max_range)
	Globals.world.spawn_entity(type, position + ant_position)


func _process(_delta: float) -> void:
	pass
