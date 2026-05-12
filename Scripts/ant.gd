extends Entity
class_name Ant


var hunger: float
var item_held: Entity


func drop_item():
	if not item_held:
		return false
	
	#functionality here !!
	
	item_held = null
	return true

func grab(item):
	if item_held:
		drop_item()
	
	#functionality here !!
	
	item_held = item

func _complete_action_logic() -> void:
	super._complete_action_logic()
	var action = get_current_action()
	if not action: return
	match action.type:
		Enums.action.GRAB:
			velocity = position.direction_to(action.targeted_position) * stats.speed
			if position.distance_to(action.targeted_entity.position) <= stats.grab_range:
				grab(action.targeted_entity)
