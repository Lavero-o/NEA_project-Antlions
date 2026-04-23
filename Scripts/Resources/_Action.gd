class_name Action extends Resource


var type: Enums.actions
var targeted_entity: Entity
var targeted_position: Vector2
var in_progress: bool = false



func _init(
	action_type: Enums.actions, 
	target_position = null, 
	target_entity = null
	):
	
	type = action_type
	targeted_entity = target_entity
	targeted_position = target_position
