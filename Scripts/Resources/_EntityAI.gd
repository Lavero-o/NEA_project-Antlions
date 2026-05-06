class_name EntityAI extends Resource

@export var allowed_actions: Array[Enums.actions]
var queued_actions: Array[Action] = []
var completing_action: bool = false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass
