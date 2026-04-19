extends Node


var selected: Array[Entity] = []

var select_shader = "res://Assets/main.gdshader"

var camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_viewport().get_camera_2d()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	
	#print(event is InputEventMouseButton, event.is_pressed(), event.as_text() == "Left Mouse Button")
	if event is InputEventMouseButton and event.is_pressed() and event.as_text() == "Left Mouse Button":
		for entity in selected:
			entity.move_to(_get_mouse_pos())

func _get_mouse_pos() -> Vector2:
	if not camera:
		camera = get_viewport()
		return Vector2(0,0)
	
	return (get_viewport().get_mouse_position() - (get_viewport().get_visible_rect().size / 2)) / camera.zoom + camera.global_position


func select_entity(entity: Entity) -> void:
	var entity_list_pos = selected.find(entity)
	if entity_list_pos != -1:
		print_debug("entity {entity} already selected")
		return
	#print(entity.get_sprite().material)	
	entity.get_sprite().material.set("shader_parameter/width", 6)
	selected.append(entity)

func deselect_all() -> void:
	var to_deselect = selected.duplicate()
	for entity in to_deselect:
		deselect_entity(entity)

func deselect_entity(entity: Entity) -> void:
	var entity_list_pos = selected.find(entity)
	if entity_list_pos == -1:
		print_debug("entity {entity} already deselected")
		return
	entity.get_sprite().material.set("shader_parameter/width", 0)
	selected.remove_at(entity_list_pos)


func _on_entities_selected(entities: Array[Entity]) -> void:
	#print(entities)
	deselect_all()
	for entity in entities:
		select_entity(entity)
