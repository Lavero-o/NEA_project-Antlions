extends Node


var selecting: bool = false

var selection_start: Vector2
var selection_end: Vector2


var selection_rect: Rect2

@export var selection_rect_node: ColorRect


func _input(event: InputEvent) -> void:
	if event.is_echo():
		return
	
	if Input.is_action_just_pressed_by_event("select", event):
		selecting = true
		selection_start = get_viewport().get_mouse_position()
	if Input.is_action_just_released_by_event("select", event):
		selecting = false
		selection_end = get_viewport().get_mouse_position()

func _process(delta: float) -> void:
	if selecting:
		if not selection_rect:
			selection_rect = Rect2()
		selection_rect.position = selection_start
		selection_rect.end = selection_end

func draw_rect() -> void:
	
	pass
