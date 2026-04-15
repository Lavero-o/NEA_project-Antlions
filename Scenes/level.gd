extends Node2D

var test_entity_path = "res://Prefabs/test_entity.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%World.spawn_entity(get_tree().test_entity_path)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
