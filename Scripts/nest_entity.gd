extends Structure
class_name Nest

var entity_node: Node2D

@export_group('Nest properties')
@export var queen_cap: int = 1
@export var ant_cap: int = 10
@export var food_cap: int = 30
@export var inv_cap: int = 20

@export_group('Starting values', 'start_')
@export var start_queens: int = 1
@export var start_worker_ants: int = 1
@export var start_scout_ants: int = 2
@export var start_fighter_ants: int = 2
@export var start_food: int = 10

#temporary
var ant_scene = preload("res://Prefabs/_Fundamentals/ant.tscn")

var worker_ant_scene: PackedScene
var scout_ant_scene: PackedScene
var fighter_ant_scene: PackedScene


var queens: Array
var ants: Array
var food: int


func _world_ready() -> void:
	entity_node = world_node.entity_node
	
	#queens = start_queens
	for i in range(start_worker_ants+start_scout_ants+start_fighter_ants):
		_spawn_ant(ant_scene.duplicate(true))


func _init() -> void:
	food = start_food
	Globals.get_world().world_ready.connect(_world_ready)


func _spawn_ant(ant_scene_param: PackedScene):
	var ant = ant_scene_param.instantiate()
	entity_node.add_child(ant)
	var spawn_range = 10
	ant.position = position + Vector2(randf_range(spawn_range,-spawn_range), randf_range(spawn_range,-spawn_range))


func _process(_delta: float) -> void:
	pass
