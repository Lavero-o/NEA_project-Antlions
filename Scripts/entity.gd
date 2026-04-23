extends CharacterBody2D
class_name Entity

const position_procimity_acceptance: float = 10
const min_velocity_cancelation_threshold: float = 20

@export_group('Stats')
@export var health: float = 60
@export var speed: float = 20
@export_group('Variables')
@export var is_stationary: bool = false
@export var is_selectable: bool = true
@export_group('Behaviour')
@export var allowed_actions: Array[Enums.actions]
@export var AI: EntityAI

var friction: float = 10.0

var moving_to: Vector2
var is_moving_to_point: bool

var turn_speed: float = 0.1
var actions: Array[Action] = []



func _physics_process(delta: float) -> void:
	if is_stationary : return
	if actions.is_empty(): return
	
	var action = actions[0]
	if position.distance_to(action.targeted_position) < position_procimity_acceptance:
		print("Action completed!")
		actions.remove_at(0)
	elif velocity.length() < min_velocity_cancelation_threshold:
		print("Action canceled...")
		actions.remove_at(0)
	
	velocity = position.direction_to(action.targeted_position) * speed
	
	position += velocity * delta
	move_and_slide()


func add_action(action: Action, additive: bool = false) -> void:
	if action.type not in allowed_actions : return
	if not additive:
		actions = []
	actions.append(action)


func _get_move_vector() -> Vector2:
	if not is_moving_to_point : pass
	return (moving_to - position).normalized()

func complete_logic():
	print(actions)

func _calculate_moving(delta: float) -> void:
	if is_moving_to_point:
		var move_vector = _get_move_vector()
		velocity = move_vector * speed * 10
		if velocity.length() * delta > _get_moving_point_vector().length():
			position = moving_to
			velocity = Vector2.ZERO
			#print("ended moving to:", moving_to)
	else:
		velocity = Vector2.ZERO
	#Action.ActionParams.new()

func _get_moving_point_vector() -> Vector2:
	return moving_to - position

func get_sprite() -> Sprite2D:
	return $Sprite2D

func move_to(point: Vector2) -> void:
	if is_stationary:
		return
	is_moving_to_point = true
	moving_to = point
	#print("started moving towards:",moving_to)
