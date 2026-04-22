class_name Action

var entity: Entity
var type: Enums.actions
var params: Action.Params
var progressing: bool


class Params:
	
	var target_pos: Vector2
	var target_entity: Entity
	
	func _init(_target_pos = null, _target_entity = null) -> void:
		self.target_pos = _target_pos
		self.target_entity = _target_entity


func _init(_action_type: Enums.actions, parameters: Action.Params):
	type = _action_type
	params = parameters
	pass


static func _static_init() -> void:
	Node.new()
	pass
