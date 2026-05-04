extends Node


var entity_reference: Dictionary[Enums.entity, Entity] = {
		Enums.entity.ANT : preload("res://Prefabs/_Fundamentals/ant.tscn").instantiate(),
		Enums.entity.BERRY : preload("res://Prefabs/Items/berry.tscn").instantiate(),
		Enums.entity.NEST : preload("res://Prefabs/Structures/nest_entity.tscn").instantiate(),
}


var camera : Camera2D
var world : World
var world_rect : Rect2 = Rect2(0,0,0,0)
var canvas_name : String = "CanvasLayer"
var select_shader: Shader = preload("res://Assets/main.gdshader")


func _ready() -> void:
	pass



func screen_to_global(position: Vector2):
	if not camera : return
	return (position + get_viewport().canvas_transform.origin*-1) / get_viewport().get_camera_2d().zoom


func get_camera():
	if camera : return camera


func set_camera(new_camera):
	camera = new_camera


func get_world_rect():
	return world_rect


func get_world():
	if world : return world


func set_world(new_world: World):
	
	world = new_world
	
	world_rect = Rect2(world.get_used_rect())
	world_rect.size *= world.scale.x


func new_entity_by_type(type: Enums.entity, parent = null) -> Entity:
	var entity : Entity = entity_reference[type].duplicate()
	entity.material = ShaderMaterial.new()
	entity.material.shader = select_shader.duplicate_deep()
	if parent is Node:
		parent.add_child(entity)
	return entity
