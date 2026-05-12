#Base class for all the game objects that will interact with the world and eachother.
extends CharacterBody2D
class_name Entity

signal entity_ready

const position_procimity_acceptance: float = 10
const min_velocity_cancelation_threshold: float = 0
const shove_strength: float = 200

@export_group('Stats')
@export var stats: EntityStats
@export_group('Variables')
@export var is_stationary: bool = false
@export var is_selectable: bool = true
@export_group('Behaviour')
@export var allowed_actions: Array[Enums.action]
@export var AI: EntityAI

var team_id: int = -1
var player_id: int = -1
var friction: float = 5.0
var turn_speed: float = 10

var is_stored: bool
var actions: Array[Action] = []


func _ready() -> void:
	if stats:
		stats.died.connect(kill)
	entity_ready.connect(_entity_ready)

func _entity_ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if is_stationary : return
	
	_complete_action_logic()
	_apply_friction(delta)
	_apply_rotation(delta)
	_shove_entities(delta)
	
	move_and_slide()

func set_color(color) -> void:
	_get_shader().set_shader_parameter("color", color)
	_get_shader().set_shader_parameter("width", 5.0)
	pass

func add_action(action: Action, additive: bool = false, first: bool = false) -> bool:
	if action.type not in allowed_actions: return false
	
	if not additive: 
		cancel_actions()
	action.owner = self
	
	if first:
		actions.push_front(action)
	else:
		actions.append(action)
	
	return true

func remove_action(action: Action) -> bool:
	if action not in actions: return false
	
	actions.erase(action)
	action.free()
	
	return true

func cancel_actions() -> void:
	var actions_copy: Array[Action] = actions.duplicate()
	
	actions = []
	for action in actions_copy: 
		action.free()


func get_current_action() -> Action:
	var action
	if actions.size() > 0:
		action = actions[0]
	return action

func _complete_action_logic() -> void:
	var action = get_current_action()
	if not action: return
	match action.type:
		Enums.action.MOVE:
			velocity = position.direction_to(action.targeted_position) * stats.speed


func _apply_rotation(delta: float) -> void:
	rotation = lerp_angle(rotation, (velocity.angle() - Vector2.LEFT.angle()), turn_speed * delta)

func _apply_friction(delta: float) -> void:
	velocity = velocity.lerp(Vector2.ZERO, delta*friction)

func _shove_entities(_delta: float):
	pass


func _get_sprite() -> Sprite2D:
	return $Sprite2D

func _get_shader() -> ShaderMaterial:
	return _get_sprite().material

func _set_material(new_material: Material) -> void:
	_get_sprite().material = new_material


func kill() -> void:
	queue_free()
