extends Entity

@export var enabled: bool = true
var camera: Camera2D

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if not camera:
		camera = Globals.get_camera()
	if not enabled:
		return
	
	#print(event is InputEventMouseButton, event.is_pressed(), event.as_text() == "Left Mouse Button")
	if event is InputEventMouseButton and event.is_pressed() and event.as_text() == "Left Mouse Button":
		move_to(_get_mouse_pos())

func _get_mouse_pos() -> Vector2:
	return (get_viewport().get_mouse_position() - (get_viewport().get_visible_rect().size / 2)) / camera.zoom + camera.global_position
