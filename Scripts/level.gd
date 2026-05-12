extends Node2D

@export var team_colors: GradientTexture1D
@export_category("Variables")
@export var food_amount: int = 50
@export var starting_number_of_ants: int = 5

func _ready() -> void:
	Game.world = %World
	Game.entity_node = %Entities
	Game.team_gradient = team_colors
	Game.init_game()
