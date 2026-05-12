extends Node

const PLAYER_CAMERA_SCENE = preload("uid://c17pvxitb5fqr")

var controller: ClientController
var camera: Camera2D


func add_client_controller(client_controller: ClientController) -> void:
	controller = client_controller
