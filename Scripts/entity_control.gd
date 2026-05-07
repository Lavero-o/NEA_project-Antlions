extends Node

var select_shader = "res://Assets/main.gdshader"

var camera

func _ready() -> void:
	Player.connect("entities_selected",_add_width)
	Player.connect("entities_deselected",_remove_width)
	camera = get_parent()



func _update_shader(entities: Array[Entity], selected: bool):
	var new_width = 6
	if not selected:
		new_width = 0
	for entity in entities:
		entity._get_shader().set_shader_parameter("width", new_width)


func _add_width(entities: Array[Entity]):
	_update_shader(entities,true)

func _remove_width(entities: Array[Entity]):
	_update_shader(entities,false)


func _input(_event: InputEvent) -> void:
	
	#print(event is InputEventMouseButton, event.is_pressed(), event.as_text() == "Left Mouse Button")
	if Input.is_action_just_pressed("click"):
		var mouse_pos: Vector2 = Globals.camera.get_global_mouse_position()
		var target: Entity
		
		if Player.action_mode == Enums.actions.GRAB:
			var existing_entities = Globals.world.entity_node.get_children()
			for existing_entity in existing_entities:
				var rect: Rect2 = existing_entity.find_child("CollisionShape2D").shape.get_rect()
				rect.position += existing_entity.position
				if rect.has_point(mouse_pos):
					target = existing_entity
					break
		
		for entity in Player.selected:
			entity.add_action(Action.new(Player.action_mode, mouse_pos, target), Input.is_action_pressed("additive_key"))


func _on_entities_selected(entities: Array[Entity]) -> void:
	Player.select_entities(entities, Input.is_action_pressed("additive_key"))
	#select_entities(entities, Input.is_action_pressed("additive_key"))
