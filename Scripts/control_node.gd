extends Node

@export var player: Player
@export var zoom_amount: float = 1.1

var test_count = 0

var panning = false


func _input(event: InputEvent) -> void:
	if event.is_echo():
		return
	
	handle_movement_input(event)
	
	handle_zoom_input(event)
	
	handle_pan_start(event)
	handle_pan(event)

func handle_movement_input(event: InputEvent) -> void:
	if not event is InputEventKey:
		pass
	
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

func handle_zoom_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton and not event.is_pressed():
		return
	
	if Input.is_action_just_pressed('zoom_in'):
		player.zoom_in(zoom_amount)
	if Input.is_action_just_pressed('zoom_out'):
		player.zoom_out(zoom_amount)

func handle_pan_start(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	
	panning = Input.is_action_pressed("pan_camera")

func handle_pan(event: InputEvent) -> void:
	if not event is InputEventMouseMotion or not panning:
		return
	print(event.get_class()," ", event is InputEventMouseMotion," ", event is InputEventMouseButton)
	player.move_cam_by(-event.relative / player.zoom)
