extends Node2D


@export_category("Variables")
@export var number_of_teams: int = 2
@export var food_amount: int = 50
@export var starting_number_of_ants: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in food_amount:
		%World.random_spawn_entity(Enums.entity.BERRY)
	#var pos = %World.entity_node.find_child("nest_entity")
	#for ant in starting_number_of_ants:
		#Globals.new_entity_by_type(Enums.entity.ANT,%World.entity_node)
