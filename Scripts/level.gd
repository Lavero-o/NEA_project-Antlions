extends Node2D

var nest_entity_scene = preload("res://Prefabs/Structures/nest_entity.tscn")
var berry_item_scene = preload("res://Prefabs/Items/berry.tscn")

@export_category("Variables")
@export var number_of_teams: int = 2
@export var food_amount: int = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var berry_item = berry_item_scene.instantiate()
	for i in food_amount:
		%World.spawn_entity(berry_item.duplicate())
	pass
