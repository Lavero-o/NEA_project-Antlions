extends Node


signal game_started
signal game_ended
signal game_loaded


var entity_reference: Dictionary[Enums.entity, PackedScene] = {
		Enums.entity.ANT : preload("res://Prefabs/_Fundamentals/ant.tscn"),
		Enums.entity.BERRY : preload("res://Prefabs/Items/berry.tscn"),
		Enums.entity.NEST : preload("res://Prefabs/Structures/nest_entity.tscn"),
}

var camera : Camera2D
var world : World
var world_rect : Rect2 = Rect2(0,0,0,0)
var canvas_name : String = "CanvasLayer"
var select_shader: Shader = preload("res://Assets/select_shader.gdshader")
var shader_material: ShaderMaterial


func _ready() -> void:
	shader_material = ShaderMaterial.new()
	shader_material.shader = select_shader
	pass

func screen_to_global(position: Vector2):
	if not camera : return
	return (position + get_viewport().canvas_transform.origin*-1) / get_viewport().get_camera_2d().zoom


func get_camera():
	if camera : return camera


func set_camera(new_camera):
	camera = new_camera
	if world:
		game_loaded.emit()


func get_world_rect():
	return world_rect


func get_world():
	if world : return world


func set_world(new_world: World):
	
	world = new_world
	
	world_rect = Rect2(world.get_used_rect())
	world_rect.size *= world.scale.x
	if camera:
		game_loaded.emit()


func new_entity_by_type(type: Enums.entity) -> Entity:
	var entity_scene: PackedScene = entity_reference[type]
	var entity: Entity = entity_scene.instantiate()
	entity._set_material(shader_material.duplicate())
	if world: world.entity_node.add_child(entity)
	
	return entity
