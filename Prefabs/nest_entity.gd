extends Entity

@export_group('Nest properties')
@export var queen_cap: int = 1
@export var ant_cap: int = 10
@export var food_cap: int = 30
@export var inv_cap: int = 20

@export_group('Starting values', 'start_')
@export var start_queens: int = 1
@export var start_worker_ant: int = 1
@export var start_scout_ant: int = 2
@export var start_fighter_ant: int = 2
@export var start_food: int = 10


var worker_ant_scene: PackedScene
var scout_ant_scene: PackedScene
var fighter_ant_scene: PackedScene



var queens: Array
var ants: Array
var food: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#queens = start_queens
	ants.append(1)
	food = start_food


func _spawn_ant():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
