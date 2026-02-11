extends Node


@export var canvas: CanvasLayer

var selecting: bool = false

var selection_start: Vector2
var selection_end: Vector2


var selection_rect: Rect2 

@export var selection_rect_scene: PackedScene
var selection_rect_node: ColorRect


func _ready() -> void:
	selection_rect_node = selection_rect_scene.instantiate()

func process_input() -> void:
	if Input.is_action_just_pressed("select"):
		print("selected")
		selecting = true
		selection_start = get_viewport().get_mouse_position()
	if Input.is_action_just_released("select"):
		print("un-selected")
		selecting = false
		selection_end = get_viewport().get_mouse_position()


func _process(delta: float) -> void:
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
