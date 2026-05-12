extends Node


@export_category("Variables")
@export var food_amount: int = 50
@export var starting_number_of_ants: int = 5

var world: World
var entity_node: Node2D
var team_gradient: GradientTexture1D

var outline_shader: Shader = preload("uid://dkvvfvxbqmy6s")
var outline_shader_material: ShaderMaterial

var teams: Array[Team] = []
var client_player: Player


func _ready() -> void:
	outline_shader_material = ShaderMaterial.new()
	outline_shader_material.shader = outline_shader
	pass
	#Globals.game_loaded.connect(_game_loaded)
	#init_game(team_info_array)

func init_game() -> void:
	#spawn berries on grass
	for i in food_amount:
		var berry: Berry = spawn_entity(Enums.entity.BERRY)
		berry.position = world.get_random_valid_pos()
	
	#initialise teams and players
	var team_info_array: Array[LobbyTeamInfo] = Globals.team_info_array
	for team_info in team_info_array:
		var team = Team.new(team_info.get_player_info_array())
		teams.append(team)
	
	#setting team colors
	var color_array: Array[Color] = get_spread_color_array(teams.size())
	for i in teams.size():
		var color = color_array[i]
		teams[i].set_color(color)
	
	#create nests
	for team in teams:
		for player in team.players:
			var nest: Nest = spawn_entity(Enums.entity.NEST, player)
			nest.position = world.get_random_valid_pos()
			var number_of_ants: int = 5
			for i in number_of_ants:
				nest.spawn_ant(Enums.entity.ANT)

func spawn_entity(entity_type: Enums.entity, player: Player = null) -> Entity:
	var entity: Entity = Globals.entity_reference[entity_type].instantiate()
	entity._set_material(outline_shader_material.duplicate())
	entity_node.add_child(entity)
	if player:
		player.add_entity(entity)
	entity.entity_ready.emit()
	return entity

#func _game_loaded() -> void:
	#for i in food_amount:
		#Globals.world.random_spawn_entity(Enums.entity.BERRY)

func get_spread_color_array(number_of_teams) -> Array[Color]:
	var color_array: Array[Color]
	number_of_teams -= 1
	for i in number_of_teams:
		color_array.append(team_gradient.gradient.sample(float(i)/float(number_of_teams)))
	color_array.append(team_gradient.gradient.sample(1))
	return color_array

func get_player_by_id(player_id) -> Player:
	var found_player: Player = null
	for team in teams:
		if found_player: break
		for player in team.players:
			if player.player_id == player_id:
				found_player = player
				break
	return found_player

func get_team(team_ID_to_find: int) -> Team:
	var found_team: Team
	for team in teams:
		if team.ID == team_ID_to_find:
			found_team = team
	return found_team
