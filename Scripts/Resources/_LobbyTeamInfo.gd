class_name LobbyTeamInfo extends Resource

static var next_team_id: int = 0

var team_id: int
var player_info_array: Array[LobbyPlayerInfo]

func _init(_player_info_array: Array[LobbyPlayerInfo] = []):
	team_id = next_team_id
	next_team_id += 1
	if _player_info_array:
		for player_info in _player_info_array:
			add_player_info(player_info)

func add_player_info(player_info: LobbyPlayerInfo) -> void:
	player_info_array.append(player_info)

func get_player_info_array() -> Array[LobbyPlayerInfo]:
	return player_info_array
