class_name EntityStats extends Resource

signal died

@export var health: float = 20
@export var speed: float = 10
@export var strength: float = 10
@export var capacity: float = 5
@export var grab_range: float = 30

func take_damage(amount: int) -> void:
	health -= amount
	health = max(health, 0)
	
	if health == 0:
		died.emit()
