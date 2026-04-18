extends Node

signal entities_selected(entities: Array[Entity])

@export var canvas: CanvasLayer
@onready var selection_area = $"../SelectionArea"
@onready var collision_shape = $"../SelectionArea/CollisionShape2D"


var selecting: bool = false
var selection_start: Vector2
var selection_end: Vector2
var selection_rect: Rect2 

var mouse_distance_from_start: float

@export var selection_rect_scene: PackedScene
var selection_rect_node: ColorRect


func _ready() -> void:
	selection_rect_node = selection_rect_scene.instantiate()

func process_input() -> void:
	if Input.is_action_just_pressed("select"):
		selecting = true
		selection_start = get_viewport().get_mouse_position()
		#print("selected",(selection_start + get_viewport().canvas_transform.origin*-1)/get_viewport().get_camera_2d().zoom)
		
	if Input.is_action_just_released("select"):
		selecting = false
		selection_end = get_viewport().get_mouse_position()
		#print("un-selected",(selection_end + get_viewport().canvas_transform.origin*-1)/get_viewport().get_camera_2d().zoom)
		
		entities_selected.emit(await get_entities_witnin_rect())

func screen_to_global_position(pos) -> Vector2:
	return (pos + get_viewport().canvas_transform.origin*-1) / get_viewport().get_camera_2d().zoom

func get_entities_witnin_rect() -> Array[Entity]:
	var entities: Array[Entity] = []
	var rect = Rect2()
	rect.position = screen_to_global_position(selection_start)
	rect.end = screen_to_global_position(selection_end)
	
	selection_area.position = rect.get_center()
	collision_shape.shape.size = abs(rect.size)
	
	var scene_tree = get_tree()
	await scene_tree.physics_frame
	await scene_tree.physics_frame
	
	var found_entities = selection_area.get_overlapping_bodies()
	
	for entity in found_entities:
		if entity is Entity:
			entities.append(entity)
	#print(entities)
	#print(selection_area.position)
	#print(collision_shape.shape.size)
	return entities

func _process(_delta: float) -> void:
	process_input()
	
	if selecting:
		if not selection_rect_node.is_inside_tree():
			canvas.add_child(selection_rect_node)
		
		selection_rect.position = selection_start
		selection_rect.end = get_viewport().get_mouse_position()
		
		draw_rect()
	else:
		if selection_rect_node.is_inside_tree():
			canvas.remove_child(selection_rect_node)

func draw_rect() -> void:
	selection_rect_node.set_position(selection_rect.abs().position)
	selection_rect_node.set_end(selection_rect.abs().end)
