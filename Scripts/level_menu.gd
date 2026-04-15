extends Control

var level_scene_path: String = "res://Scenes/level.tscn"

func _on_close_button_pressed() -> void:
	queue_free()


func _on_new_button_pressed() -> void:
	get_tree().change_scene_to_file(level_scene_path)
