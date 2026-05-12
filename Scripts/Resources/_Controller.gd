#Info: Contains all the functions that are required to control the units. Parent class for ClientController and AIController
class_name Controller extends Resource

const CONTROLLER_SCENE = preload("uid://dthi3n88tcckf")

var player: Player

signal action_added_to_entities(entities: Array[Entity], action: Action, additive: bool, first: bool)
signal action_removed_from_entities(entities: Array[Entity], action: Action)
signal actions_canceled_from_entities(entities: Array[Entity])


func _init(owner_player: Player = null):
	if not owner_player: return
	add_player(owner_player)

func add_player(_player) -> void:
	player = _player
	_player._add_controller(self)

func add_action(entities: Array[Entity], action: Action, additive: bool = false, first: bool = false) -> void:
	action_added_to_entities.emit(entities, action, additive, first)

func remove_action(entities: Array[Entity], action: Action) -> void:
	action_removed_from_entities.emit(entities, action)

func cancel_actions(entities: Array[Entity]) -> void:
	actions_canceled_from_entities.emit(entities)


func get_player_entities() -> Array[Entity]:
	if not player: return []
	return player.get_entities()

static func get_controller_from_type(controller_type: Enums.controller) -> Controller:
	var controller: Controller
	match controller_type:
		Enums.controller.AI:
			controller = AIController.new()
		Enums.controller.CLIENT:
			controller = ClientController.new()
		#Enums.controllers.SIDE:
			#controller =
	return controller
