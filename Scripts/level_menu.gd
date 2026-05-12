extends Control

var level_scene: PackedScene = preload("uid://dbvfqpdbm38v2")

func _on_close_button_pressed() -> void:
	queue_free()


func _on_new_button_pressed() -> void:
	get_tree().change_scene_to_packed(level_scene)
