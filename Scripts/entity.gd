extends CharacterBody2D
class_name Entity

const position_procimity_acceptance: float = 10
const min_velocity_cancelation_threshold: float = 0
const shove_strength: float = 200

@export_group('Stats')
@export var stats: EntityStats
@export_group('Variables')
@export var is_stationary: bool = false
@export var is_selectable: bool = true
@export_group('Behaviour')
@export var allowed_actions: Array[Enums.actions]
@export var AI: EntityAI

var team_number: int = -1
var collider_radius: float
var friction: float = 5.0
var moving_to: Vector2
var is_moving_to_point: bool
var is_stored: bool
var turn_speed: float = 10
var actions: Array[Action] = []
var items_held: Array[Item] = []


func add_action(action: Action, additive: bool = false) -> void:
	action.owner = self
	if action.type not in allowed_actions : return
	if not additive:
		actions = []
	actions.append(action)


func select() -> bool:
	return Player.select_entity(self)


func deselect() -> bool:
	return Player.deselect_entity(self)


func kill() -> void:
	queue_free()


func grab(_item: Item) -> void:
	pass



func _ready() -> void:
	stats.died.connect(kill)

func _physics_process(delta: float) -> void:
	if is_stationary : return
	
	_complete_action_logic()
	_apply_friction(delta)
	_apply_rotation(delta)
	_shove_entities(delta)
	
	move_and_slide()

func _get_move_vector() -> Vector2:
	if not is_moving_to_point : pass
	return (moving_to - position).normalized()

func _complete_action_logic() -> void:
	if actions.size() > 0:
		var action: Action = actions[0]
		
		if action.check_completion():
			actions.remove_at(0)
			return
		
		match action.type:
			Enums.actions.MOVE:
				velocity = position.direction_to(action.targeted_position) * stats.speed
			Enums.actions.GRAB:
				velocity = position.direction_to(action.targeted_position) * stats.speed
				if position.distance_to(action.targeted_entity.position) <= stats.grab_range:
					grab(action.targeted_entity)

func _apply_friction(delta: float) -> void:
	velocity = velocity.lerp(Vector2.ZERO, delta*friction)

func _apply_rotation(delta: float) -> void:
	rotation = lerp_angle(rotation, (velocity.angle() - Vector2.LEFT.angle()), turn_speed * delta)

func _shove_entities(_delta: float):
	pass

func _get_sprite() -> Sprite2D:
	return $Sprite2D

func _get_shader() -> ShaderMaterial:
	return _get_sprite().material

func _set_material(new_material: Material) -> void:
	_get_sprite().material = new_material
