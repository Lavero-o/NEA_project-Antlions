extends Node2D


@export_category("Variables")
@export var number_of_teams: int = 2
@export var food_amount: int = 50
@export var starting_number_of_ants: int = 5

var select_shader: Shader = preload("res://Assets/select_shader.gdshader")
var teams: Array[Team] = []


func _ready() -> void:
	Globals.game_loaded.connect(_game_loaded)

func _game_loaded() -> void:
	for num in number_of_teams:
		teams.append(Team.new(num+1))
	for i in food_amount:
		Globals.world.spawn_berry(5,10)
