extends  Node


var action_mode: Enums.actions = Enums.actions.NONE
var selected: Array[Entity]
var team_id: int

signal entities_selected(entities: Array[Entity])
signal entities_deselected(entities: Array[Entity])


func set_action_mode(new_action_mode: Enums.actions):
	
	action_mode = new_action_mode
	


func deselect_entities(entities: Array[Entity]):
	
	var desel_ent: Array[Entity] = []
	
	for entity in entities:
		var array_index = selected.find(entity)
		if array_index == -1 : continue
		
		selected.remove_at(selected.find(entity))
		desel_ent.append(entity)
	
	entities_deselected.emit(desel_ent)
	


func deselect_all():
	
	entities_deselected.emit(selected)
	selected = []
	


func select_entities(entities: Array[Entity], additive = false):
	
	if not additive:
		var ent_to_desel: Array [Entity]
		
		for entity in selected:
			if entity not in entities:
				ent_to_desel.append(entity)
		
		deselect_entities(ent_to_desel)
	
	var sel_ent: Array[Entity] = []
	
	for entity in entities:
		if entity not in selected:
			sel_ent.append(entity)
			selected.append(entity)
	
	entities_selected.emit(sel_ent)
	
