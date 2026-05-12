extends Structure
class_name Nest

@export_group('Nest properties')
@export var queen_cap: int = 1
@export var ant_cap: int = 10
@export var food_cap: int = 30
@export var inv_cap: int = 20

#temporary
var ant_base_node = preload("res://Prefabs/_Fundamentals/ant.tscn").instantiate()

var worker_ant_scene: PackedScene
var scout_ant_scene: PackedScene
var fighter_ant_scene: PackedScene


var queens: Array
var ants: Array
var food: int


func _entity_ready() -> void:
	#var number_of_ants: int = 5
	#for i in number_of_ants:
		#spawn_ant(Enums.entity.ANT)
	pass

func spawn_ant(type: Enums.entity):
	
	var min_range = 35
	var max_range = 50
	
	var ant_position = Vector2.UP.rotated(randf()*2*PI) * randf_range(min_range,max_range)
	print(player_id)
	var ant = Game.spawn_entity(type, Game.get_player_by_id(player_id))
	ant.position = ant_position + position


func _process(_delta: float) -> void:
	pass
