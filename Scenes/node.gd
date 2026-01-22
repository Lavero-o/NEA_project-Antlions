extends Node

@export var entity: Entity
@export var camera: Camera2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() == true:
		entity.move_to(_get_mouse_pos())

func _get_mouse_pos() -> Vector2:
	return (get_viewport().get_mouse_position() - (get_viewport().get_visible_rect().size / 2)) / camera.zoom + camera.global_position
