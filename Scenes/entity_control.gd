extends Node


var selected: Array[Entity] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func select_entity(entity: Entity) -> void:
	var entity_list_pos = selected.find(entity)
	if entity_list_pos == -1:
		print_debug("entity {entity} already selected")
		return
	selected.append(entity)

func deselect_all() -> void:
	selected.clear()

func deselect_entity(entity: Entity) -> void:
	var entity_list_pos = selected.find(entity)
	if entity_list_pos == -1:
		print_debug("entity {entity} already deselected")
		return
	selected.remove_at(entity_list_pos)
