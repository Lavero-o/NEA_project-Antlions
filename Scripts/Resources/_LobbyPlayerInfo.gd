#Info: Container for player info that gets passed to the game so it can create propper teams with players
class_name LobbyPlayerInfo extends Resource

var next_player_id: int = 0

var player_id: int
var type: Enums.controller

func _init(_type: Enums.controller):
	player_id = next_player_id
	next_player_id += 1
	
	type = _type
