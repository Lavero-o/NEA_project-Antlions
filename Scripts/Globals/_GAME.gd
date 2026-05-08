extends Node2D


@export_category("Variables")
@export var number_of_teams: int = 2
@export var food_amount: int = 50
@export var starting_number_of_ants: int = 5

var select_shader: Shader = preload("res://Assets/select_shader.gdshader")
var teams: Array[Team] = []

var client_player: Player

func load_game(players: Array[LobbyPlayerInfo], number_of_teams: int) -> void:
	for team_ID in number_of_teams:
		teams.append(Team.new(team_ID+1, Team.get_players_for_team(team_ID, players)))

func spawn_entity(entity_type: Enums.entity, team_ID: int = -1, player_ID: int = -1, arguments: Dictionary[String, Variant] = {}) -> void:
	
	pass

func _ready() -> void:
	Globals.game_loaded.connect(_game_loaded)

func _game_loaded() -> void:
	for num in number_of_teams:
		teams.append(Team.new(num+1))
	for i in food_amount:
		Globals.world.random_spawn_entity(Enums.entity.BERRY)
