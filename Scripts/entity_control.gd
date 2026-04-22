extends Node


var selected: Array[Entity] = []

var select_shader = "res://Assets/main.gdshader"

var camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	
	#print(event is InputEventMouseButton, event.is_pressed(), event.as_text() == "Left Mouse Button")
	if event is InputEventMouseButton and event.is_pressed() and event.as_text() == "Left Mouse Button":
		for entity in selected:
			entity.add_action(Action.new(Enums.actions.MOVE, Action.Params.new(_get_mouse_pos())))
			entity.perform_latest_action()

func _get_mouse_pos() -> Vector2:
	return (get_viewport().get_mouse_position() - (get_viewport().get_visible_rect().size / 2)) / camera.zoom + camera.global_position


func select_entity(entity: Entity) -> void:
	if entity in selected : return
	entity.get_sprite().material.set("shader_parameter/width", 6)
	selected.append(entity)

func deselect_entity(entity: Entity) -> void:
	if not entity in selected : return
	entity.get_sprite().material.set("shader_parameter/width", 0)
	selected.erase(entity)


func deselect_all() -> void:
	var to_deselect = selected.duplicate()
	for entity in to_deselect:
		deselect_entity(entity)


func deselect_entities(entities: Array[Entity]):
	for entity in entities:
		deselect_entity(entity)


func select_entities(entities: Array[Entity], additive: bool = false):
	
	if not additive:
		var to_desel: Array[Entity] = []
		for entity in selected:
			if not entity in entities:
				to_desel.append(entity)
		deselect_entities(to_desel)
		print(to_desel)
	
	for entity in entities:
		select_entity(entity)

func _on_entities_selected(entities: Array[Entity]) -> void:
	select_entities(entities)
