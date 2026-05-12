#Info: Contains identifiers and Entities of different players (including AI) while being controlled by a Controller
class_name Player extends Resource

static var next_player_id: int = 0

var player_id: int
var team: Team
var entities: Array[Entity]
var controller: Controller
var nest: Nest
var color: Color


func _init():
	player_id = next_player_id
	next_player_id += 1
	

func set_team(_team: Team) -> void:
	team = _team

func get_team() -> Team:
	return team

func add_controller(_controller: Controller = null, controller_type: Enums.controller = Enums.controller.NONE) -> void:
	if _controller:
		controller = _controller
	elif controller_type != Enums.controller.NONE:
		controller = Controller.get_controller_from_type(controller_type)
	if not controller:
		return
	
	controller.action_added_to_entities.connect(add_action_to_entities)
	controller.action_removed_from_entities.connect(remove_action_from_entities)
	controller.actions_canceled_from_entities.connect(cancel_actions_from_entities)


func add_action_to_entities(_entities: Array[Entity], action: Action, additive: bool, first: bool):
	for entity in _entities:
		entity.add_action(action, additive, first)

func remove_action_from_entities(_entities: Array[Entity], action: Action):
	for entity in _entities:
		entity.remove_action(action)

func cancel_actions_from_entities(_entities: Array[Entity]):
	for entity in _entities:
		entity.cancel_actions()

func add_entity(entity: Entity) -> void:
	entity.player_id = player_id
	entity.team_id = team.team_id
	entity.set_color(color)
	entities.append(entity)

func set_color(_color: Color) -> void:
	color = _color

func get_entities() -> Array[Entity]:
	return entities
