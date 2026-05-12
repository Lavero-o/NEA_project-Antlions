extends Node

signal game_started
signal game_ended
signal game_loaded

@export var team_colors: GradientTexture1D

var entity_reference: Dictionary[Enums.entity, PackedScene] = {
		Enums.entity.ANT : preload("uid://c28nxvnatxwno"),
		Enums.entity.BERRY : preload("uid://melhnvh528da"),
		Enums.entity.NEST : preload("uid://js6u6r2008d3"),
}

var camera : Camera2D
var world : World
var world_rect : Rect2 = Rect2(0,0,0,0)
var canvas_name : String = "CanvasLayer"
var select_shader: Shader = preload("uid://dkvvfvxbqmy6s")
var shader_material: ShaderMaterial

# for testing purposes this array is not empty
var team_info_array: Array[LobbyTeamInfo] = [
	LobbyTeamInfo.new([LobbyPlayerInfo.new(Enums.controller.CLIENT)]),
	LobbyTeamInfo.new([LobbyPlayerInfo.new(Enums.controller.AI)]),
	LobbyTeamInfo.new([LobbyPlayerInfo.new(Enums.controller.AI)]),
	LobbyTeamInfo.new([LobbyPlayerInfo.new(Enums.controller.AI)]),
	LobbyTeamInfo.new([LobbyPlayerInfo.new(Enums.controller.AI)])
]


func _ready() -> void:
	shader_material = ShaderMaterial.new()
	shader_material.shader = select_shader

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


#func new_entity_by_type(type: Enums.entity) -> Entity:
	#var entity_scene: PackedScene = entity_reference[type]
	#var entity: Entity = entity_scene.instantiate()
	#entity._set_material(shader_material.duplicate())
	#if world: world.entity_node.add_child(entity)
	#
	#return entity

func get_team_info_array() -> Array[LobbyTeamInfo]:
	return team_info_array
