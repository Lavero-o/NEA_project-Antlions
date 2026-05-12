class_name ClientController extends Controller

var action_mode: Enums.action = Enums.action.MOVE
var selected: Array[Entity]
var team_id: int
var selector: ClientSelector

signal entities_selected(entities: Array[Entity])
signal entities_deselected(entities: Array[Entity])


func _init():
	ClientPlayer.add_client_controller(self)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo() or not event.is_pressed(): return
	
	var new_action_mode: Enums.action
	if event.is_action("move_action") : new_action_mode = Enums.action.MOVE
	elif event.is_action("grab_action") : new_action_mode = Enums.action.GRAB
	elif event.is_action("attack_action") : new_action_mode = Enums.action.ATTACK
	elif event.is_action("build_action") : new_action_mode = Enums.action.BUILD
	elif event.is_action("defend_action") : new_action_mode = Enums.action.DEFEND
	if new_action_mode:
		print(set_action_mode(new_action_mode)) #print for input feedback
	
	


func set_action_mode(new_action_mode: Enums.action) -> Enums.action:
	action_mode = new_action_mode
	return action_mode


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
		var to_desel: Array[Entity] = selected.filter(func(ant): return not ant in entities)
		print(to_desel)
		deselect_entities(to_desel)
	
	var new_entities_selected: Array[Entity] = []
	for entity in entities:
		if select_entity(entity, true):
			new_entities_selected.append(entity)
	
	entities_selected.emit(new_entities_selected)


func deselect_all() -> void:
	var to_deselect = selected.duplicate()
	deselect_entities(to_deselect)
