extends Node


var action_mode: Enums.actions = Enums.actions.NONE
var selected: Array[Entity]
var team_id: int

signal entities_selected(entities: Array[Entity])
signal entities_deselected(entities: Array[Entity])


func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo() or not event.is_pressed(): return
	
	if event.is_action("move_action") : action_mode = Enums.actions.MOVE
	elif event.is_action("build_action") : action_mode = Enums.actions.BUILD
	elif event.is_action("attack_action") : action_mode = Enums.actions.ATTACK
	elif event.is_action("grab_action") : action_mode = Enums.actions.GRAB
	elif event.is_action("defend_action") : action_mode = Enums.actions.DEFEND
	print(action_mode)


func set_action_mode(new_action_mode: Enums.actions):
	
	action_mode = new_action_mode


func select_entity(entity: Entity, ignore_signal: bool = false) -> bool:
	if entity in selected : return false
	
	selected.append(entity)
	
	if not ignore_signal:
		entities_selected.emit([entity])
	return true


func deselect_entity(entity: Entity, ignore_signal: bool = false) -> bool:
	if not entity in selected : return false
	
	selected.erase(entity)
	
	if not ignore_signal:
		entities_deselected.emit([entity])
	return true


func deselect_entities(entities: Array[Entity]):
	var deselected: Array[Entity] = []
	for entity in entities:
		if deselect_entity(entity, true): 
			deselected.append(entity)
	entities_deselected.emit(entities)


func select_entities(entities: Array[Entity], additive: bool = false):
	
	if not additive:
		var to_desel: Array[Entity] = []
		for entity in selected:
			if not entity in entities:
				to_desel.append(entity)
		deselect_entities(to_desel)
	
	var new_entities_selected: Array[Entity] = []
	for entity in entities:
		if select_entity(entity, true):
			new_entities_selected.append(entity)
	
	entities_selected.emit(new_entities_selected)


func deselect_all() -> void:
	var to_deselect = selected.duplicate()
	deselect_entities(to_deselect)
