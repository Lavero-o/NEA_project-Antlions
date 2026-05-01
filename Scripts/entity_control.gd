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
		for entity in Player.selected:
			entity.add_action(Action.new(Player.action_mode, Globals.camera.get_global_mouse_position()), Input.is_action_pressed("additive_key"))


func _on_entities_selected(entities: Array[Entity]) -> void:
	Player.select_entities(entities, Input.is_action_pressed("additive_key"))
	#select_entities(entities, Input.is_action_pressed("additive_key"))
