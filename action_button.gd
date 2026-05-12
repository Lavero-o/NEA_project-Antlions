class_name ActionButton extends Button

var action_type: Enums.actions

var action_icons: Dictionary[Enums.actions, CompressedTexture2D] = {
	Enums.actions.MOVE : preload("uid://bag8658j4d5em"),
	Enums.actions.GRAB : preload("uid://dhbt2vdrmyym"),
	Enums.actions.ATTACK : null,
	Enums.actions.BUILD : null,
	Enums.actions.DEFEND : null,
	Enums.actions.REPAIR : null
}

func _ready() -> void:
	
	pass

func set_image(image: CompressedTexture2D) -> void:
	find_child("TextureRect").Texture = image
