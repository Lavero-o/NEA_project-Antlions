extends CharacterBody2D
class_name Entity

@export var health: float = 60
@export var speed: float = 20

var friction = 10

var moving_to: Vector2
var is_moving_to_point: bool

var turn_factor: float = 0.1

func _init() -> void:
	pass

func _physics_process(delta: float) -> void:
	if is_moving_to_point:
		var move_vector = get_move_vector()
		velocity = move_vector * speed * 10 * delta
	
	velocity.x = move_toward(velocity.x, 0, 10*delta)
	velocity.y = move_toward(velocity.y, 0, 10*delta)

func get_move_vector():
	if not is_moving_to_point:
		return
	return (moving_to - position).normalized()

func move_to(point: Vector2):
	is_moving_to_point = true
	moving_to = point
