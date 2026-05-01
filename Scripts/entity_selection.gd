extends Node


signal entities_selected(entities: Array[Entity])

@export var canvas: CanvasLayer
@export var selection_rect_scene: PackedScene
@onready var selection_area = $"../SelectionArea"
@onready var collision_shape = $"../SelectionArea/CollisionShape2D"

var to_select: Array[Entity]
var selecting: bool = false
var selection_start: Vector2
var selection_end: Vector2
var selection_rect: Rect2 
var mouse_distance_from_start: float
var selection_rect_node: ColorRect


func _ready() -> void:
	selection_rect_node = selection_rect_scene.instantiate()
	selection_area.body_entered.connect(_on_select_area_body_entered)
	selection_area.body_exited.connect(_on_select_area_body_exited)


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


func _physics_process(_delta: float) -> void:
	if not selecting : return
	update_select_area()


func _on_select_area_body_entered(body: PhysicsBody2D):
	
	if not (body is Entity and body.is_selectable) : return
	to_select.append(body)


func _on_select_area_body_exited(body: PhysicsBody2D):
	
	if not (body is Entity and body.is_selectable) : return
	to_select.erase(body)


func process_input() -> void:
	
	if Input.is_action_just_pressed("select"):
		selecting = true
		
		selection_start = get_viewport().get_mouse_position()
		#print("selected",(selection_start + get_viewport().canvas_transform.origin*-1)/get_viewport().get_camera_2d().zoom)
	
	#if Input.is_action_pressed("select"):
		#if selecting != true:
			#mouse_distance_from_start = (get_viewport().get_mouse_position() - selection_start).length()
			#if mouse_distance_from_start > 5:
				#to_select = await get_entities_witnin_select()
				#selecting = true
	
	if Input.is_action_just_released("select"):
		if not selecting:
			return
		selecting = false
		selection_end = get_viewport().get_mouse_position()
		
		to_select = await get_entities_witnin_select()
		#print("un-selected",(selection_end + get_viewport().canvas_transform.origin*-1)/get_viewport().get_camera_2d().zoom)
		entities_selected.emit(to_select)


func get_entities_witnin_select() -> Array[Entity]:
	
	var entities: Array[Entity] = []
	
	update_select_area()
	
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


func update_select_area():
	
	selection_area.position = Globals.screen_to_global(selection_rect_node.get_rect().get_center())
	collision_shape.shape.size = selection_rect_node.size/get_viewport().get_camera_2d().zoom


func draw_rect() -> void:
	
	selection_rect_node.set_position(selection_rect.abs().position)
	selection_rect_node.set_end(selection_rect.abs().end)


func screen_to_global_position(pos: Vector2) -> Vector2:
	return (pos + get_viewport().canvas_transform.origin*-1) / get_viewport().get_camera_2d().zoom


#func _on_selection_area_body_entered(body: Node2D) -> void:
	#if not (body is Entity and selecting and not body in to_select) : return
	#to_select.append(body)


#func _on_selection_area_body_exited(body: Node2D) -> void:
	#if not (body is Entity and selecting) : return
	#to_select.erase(body)
