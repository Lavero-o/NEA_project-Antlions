class_name Team extends Resource


static var next_team_id: int = 0

var players: Array[Player]

var is_playing: bool
var team_id: int
var color: Color

func _init(player_info_array: Array[LobbyPlayerInfo] = []):
	team_id = next_team_id
	next_team_id += 1
	for player_info in player_info_array:
		var new_player = add_player(Player.new())
		new_player.add_controller(null, player_info.type)

func add_player(player: Player) -> Player:
	player.set_team(self)
	players.append(player)
	return player

func get_player(player_id_to_find: int) -> Player:
	var found_player: Player
	
	for player in players:
		if player.id == player_id_to_find:
			found_player = player
	
	return found_player

func set_color(_color: Color) -> void:
	color = _color
	for player in players:
		player.set_color(color)

static func get_players_for_team(_team_id: int, _players):
	var team_players: Array[LobbyPlayerInfo]
	for player in _players:
		if player.team_id == _team_id:
			team_players.append(player)
	return team_players
