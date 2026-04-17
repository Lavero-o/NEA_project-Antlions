extends Structure
class_name Nest

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
	var entity_node = world_node.entity_node
	
	#queens = start_queens
	for i in range(start_worker_ants+start_scout_ants+start_fighter_ants):
		var ant: Ant = ant_scene.duplicate().instantiate()
		entity_node.add_child(ant)
		print(position)
		ant.position = position


func _init() -> void:
	food = start_food
	Globals.get_world().world_ready.connect(_world_ready)


func _spawn_ant():
	pass


func _process(_delta: float) -> void:
	pass
