extends Node2D

var test_entity_scene = preload("res://Prefabs/test_entity.tscn")
var nest_entity_scene = preload("res://Prefabs/nest_entity.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%World.spawn_entity(test_entity_scene)
	%World.spawn_entity(nest_entity_scene)
