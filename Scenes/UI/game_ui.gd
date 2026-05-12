extends Control

var action_button_scene: PackedScene = preload("uid://qs771538yr28")

func add_action_buttons(action_types:Array[Enums.actions]) -> void:
	
	pass

func create_action_button(action_type: Enums.actions) -> void:
	var action_button: ActionButton = action_button_scene.instantiate()
	action_button
	pass
