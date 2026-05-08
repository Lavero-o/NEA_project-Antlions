class_name Player extends Node


signal entities_action_addition(_entities: Array[Entity], action: Action)


var ID: int
var team_ID: int
var entities: Array[Entity]
var nest: Nest

func _init(player_ID: int, _team_ID: int):
	ID = player_ID
	team_ID = _team_ID

func add_action_to_entities(_entities: Array[Entity], action: Action):
	entities_action_addition.emit(_entities, action)
