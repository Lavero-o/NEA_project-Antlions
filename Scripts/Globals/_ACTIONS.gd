class_name Action

var entity: Entity
var action_enum: Enums.actions
var params: ActionParams

class ActionParams:
	
	var target_pos: Vector2
	var target_entity: Entity
	
	func _init(_target_pos: Vector2, _target_entity: Entity) -> void:
		self.target_pos = _target_pos
		self.target_entity = _target_entity
	

static func new(action_type, on_entity, parameters: ActionParams):
	
	pass
	

static func _static_init() -> void:
	
	Node.new()
	pass
	
