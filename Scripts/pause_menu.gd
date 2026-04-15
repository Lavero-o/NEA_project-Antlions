extends Control

@export var options_ui_scene: PackedScene


func _on_continue_button_pressed() -> void:
	queue_free()

func _on_options_button_pressed() -> void:
	add_child(options_ui_scene.instantiate())

func _on_save_button_pressed() -> void:
	pass # Replace with function body.

func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
