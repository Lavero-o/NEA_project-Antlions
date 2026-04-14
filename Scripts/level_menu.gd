extends Control

@export var level_scene: PackedScene

func _on_close_button_pressed() -> void:
	queue_free()



func _on_easy_level_button_pressed() -> void:
	get_tree().change_scene_to_packed(level_scene)
	pass # Replace with function body.

func _on_normal_level_button_pressed() -> void:
	pass # Replace with function body.

func _on_hard_level_button_pressed() -> void:
	pass # Replace with function body.
