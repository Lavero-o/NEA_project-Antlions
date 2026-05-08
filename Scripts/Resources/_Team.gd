class_name Team extends Resource


var players: Array


var is_playing: bool
var ID: int

func _init(_ID = -1, _players: Array[LobbyPlayerInfo] = []) -> void:
	ID = _ID
	for player in _players:
		players.append(Player.new)


static func get_players_for_team(team_ID: int, _players):
	var team_players: Array[LobbyPlayerInfo]
	for player in _players:
		if player.team_ID == team_ID:
			team_players.append(player)
	return team_players
