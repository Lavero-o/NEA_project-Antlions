extends Node2D


@export_category("Variables")
@export var number_of_teams: int = 2
@export var food_amount: int = 50
@export var starting_number_of_ants: int = 5

var select_shader: Shader = preload("res://Assets/main.gdshader")
var teams: Array[Team] = []


func _ready() -> void:
	Globals.game_loaded.connect(_game_loaded)

func _game_loaded() -> void:
	for num in number_of_teams:
		teams.append(Team.new())
	for i in food_amount:
		Globals.world.random_spawn_entity(Enums.entity.BERRY)

class Team:
	var _next_ID: int = 0
	
	var ID: int
	var nest: Nest
	var ants: Array[Ant]
	
	
	func _init(team_nest: Nest = Globals.world.random_spawn_entity(Enums.entity.NEST)) -> void:
		set_nest(team_nest)
		ID = _next_ID
		_next_ID += 1
	
	
	func set_nest(new_nest: Nest) -> void:
		nest = new_nest
		nest.team_number = ID
	func get_nest() -> Nest:
		return nest
	
	func add_ant(new_ant: Ant) -> bool:
		if new_ant in ants: return false
		ants.append(new_ant)
		new_ant.team_number = ID
		return true
	func add_ants(new_ants: Array[Ant]) -> void:
		for ant in new_ants:
			add_ant(ant)
	
	func remove_ant(ant_to_remove: Ant) -> bool:
		if not ant_to_remove in ants: return false
		ants.erase(ant_to_remove)
		ant_to_remove.team_number = -1
		return true
	func remove_ants(ants_to_remove: Array[Ant]) -> void:
		for ant in ants_to_remove:
			remove_ant(ant)
