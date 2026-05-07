class_name Action extends Resource


var owner: Entity
var type: Enums.actions
var targeted_entity: Entity
var targeted_position: Vector2
var in_progress: bool = false



func _init(
	action_type: Enums.actions, 
	target_position = null, 
	target_entity = null,
	action_owner: Entity = null
	):
	
	type = action_type
	targeted_entity = target_entity
	targeted_position = target_position
	owner = action_owner


func new_move_action(pos: Vector2) -> Action:
	return Action.new(Enums.actions.MOVE,pos)


func check_completion() -> bool:
	
	var completed = false
	
	match type:
		Enums.actions.MOVE:
			if owner.position.distance_to(targeted_position) < owner.position_procimity_acceptance:
				completed = true
		Enums.actions.GRAB:
			if not targeted_entity or targeted_entity.is_stored:
				completed = true
	return completed
