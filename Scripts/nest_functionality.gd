extends Node

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
