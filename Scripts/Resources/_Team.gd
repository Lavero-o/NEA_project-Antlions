class_name Team extends Resource

var is_playing: bool
var nest: Nest
var entities: Array[Entity]
var total_food: int
var ID: int

func _init(_ID = -1, _nest = null, _entities = null) -> void:
	ID = _ID
	if _nest:
		nest = _nest
	if _entities:
		entities = _entities

func update_food_amount() -> void:
	total_food = 0
	for entity in entities:
		if entity.stats.container:
			total_food += entity.stats.container.food
