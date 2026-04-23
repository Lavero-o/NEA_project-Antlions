class_name EntityAI extends Resource

@export var allowed_actions: Array[Enums.actions]
var queued_actions: Array[Action] = []
var completing_action: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func test() -> void:
	print('A')
	print()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
