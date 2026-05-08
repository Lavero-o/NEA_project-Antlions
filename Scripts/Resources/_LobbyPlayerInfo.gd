class_name LobbyPlayerInfo extends Resource


var ID: int
var team_ID: int
var type: Enums.players

func _init(playerID: int, player_teamID: int, player_type: Enums.players) -> void:
	ID = playerID
	team_ID = player_teamID
	type = player_type
