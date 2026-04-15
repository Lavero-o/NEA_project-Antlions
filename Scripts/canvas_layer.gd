extends CanvasLayer

@export var pause_ui_scene: PackedScene
var pause_ui_node: Control

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.as_text() == 'Escape' and event.is_pressed():
		if pause_ui_node:
			pause_ui_node.queue_free()
			pause_ui_node = null
		else:
			pause_ui_node = pause_ui_scene.instantiate()
			add_child(pause_ui_node)
