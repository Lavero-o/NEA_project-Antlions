extends Node2D


@export_category("Variables")
@export var number_of_teams: int = 2
@export var food_amount: int = 50
@export var starting_number_of_ants: int = 5

var select_shader: Shader = preload("res://Assets/main.gdshader")



class Team:
	var _next_ID: int = 0
	
	var ID: int
	var nest: Nest
	var ants: Array[Ant]
	
	func _init(team_nest) -> void:
		ID = _next_ID
		_next_ID += 1
	
	func set_nest(new_nest: Nest) -> void:
		nest = new_nest
	func get_nest() -> Nest:
		return nest
	
	func add_ant(new_ant: Ant) -> void:
		ants.append(new_ant)
	func add_ants(new_ants: Array[Ant]) -> void:
		ants.append_array(new_ants)
	
	func remove_ant(ant_to_remove: Ant) -> bool:
		if not ant_to_remove in ants:
			push_error("Trying to remove Ant when none found")
			return false
		ants.erase(ant_to_remove)
		return true
	func remove_ants(ants_to_remove: Array[Ant]) -> void:
		ants_to_remove.map(remove_ant)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in food_amount:
		%World.random_spawn_entity(Enums.entity.BERRY)
	#var pos = %World.entity_node.find_child("nest_entity")
	#for ant in starting_number_of_ants:
		#Globals.new_entity_by_type(Enums.entity.ANT,%World.entity_node)
