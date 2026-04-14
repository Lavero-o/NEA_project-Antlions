extends VBoxContainer

@export var canvas_node: CanvasLayer

@export var level_ui_scene: PackedScene
@export var options_ui_scene: PackedScene


func _on_play_button_pressed() -> void:
	var level_ui = level_ui_scene.instantiate()
	canvas_node.add_child(level_ui)


func _on_options_button_pressed() -> void:
	var options_ui = options_ui_scene.instantiate()
	canvas_node.add_child(options_ui)


func _on_quit_button_pressed() -> void:
	pass # Replace with function body.
