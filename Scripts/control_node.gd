extends Node

@export var player: Player

func _shortcut_input(event: InputEvent) -> void:
	if event.is_echo():
		return
	
	var input_vec = Vector2.ZERO
	if Input.is_action_pressed('move_up'):
		input_vec += Vector2.UP
	if Input.is_action_pressed('move_down'):
		input_vec += Vector2.DOWN
	if Input.is_action_pressed('move_left'):
		input_vec += Vector2.LEFT
	if Input.is_action_pressed('move_right'):
		input_vec += Vector2.RIGHT
	
	player.set_move_vec(input_vec)
