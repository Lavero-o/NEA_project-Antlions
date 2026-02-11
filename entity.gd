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
	_calculate_moving(delta)
	move_and_slide()

func get_move_vector() -> Vector2:
	if not is_moving_to_point:
		pass
	return (moving_to - position).normalized()

func _calculate_moving(delta: float) -> void:
	if is_moving_to_point:
		var move_vector = get_move_vector()
		velocity = move_vector * speed * 10
		if velocity.length() * delta > _get_moving_point_vector().length():
			position = moving_to
			velocity = Vector2.ZERO
			#print("ended moving to:", moving_to)
	else:
		velocity = Vector2.ZERO

func _get_moving_point_vector() -> Vector2:
	return moving_to - position

func move_to(point: Vector2) -> void:
	is_moving_to_point = true
	moving_to = point
	#print("started moving towards:",moving_to)
