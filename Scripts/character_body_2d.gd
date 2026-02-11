class_name Player
extends CharacterBody2D


@export var camera: Camera2D

const  BASE_SPEED: float = 500.0
const BASE_ACCEL: float = 1000.0
var speed_mult: float = 1.0
var speed: float = BASE_SPEED * speed_mult

var accel: float = BASE_ACCEL * zoom

var move_vector: Vector2 = Vector2.ZERO

var zoom: float = 1
var zoom_max: float = .2
var zoom_min: float = 4

func _process(delta: float) -> void:
	handle_smooth_zoom(delta)
	move_and_slide()

func _physics_process(delta: float) -> void:
	
	if move_vector.length() != 0:
		velocity.x = move_toward(velocity.x, move_vector.x*speed, delta*accel*5)
		velocity.y = move_toward(velocity.y, move_vector.y*speed, delta*accel*5)
	else:
		velocity.x = move_toward(velocity.x, 0, delta*accel)
		velocity.y = move_toward(velocity.y, 0, delta*accel)



func zoom_in(percent_amount: float) -> void:
	zoom *= percent_amount
	zoom = clampf(zoom, zoom_max, zoom_min)
	
	update_speed()

func zoom_out(percent_amount: float) -> void:
	zoom /= percent_amount
	zoom = clampf(zoom, zoom_max, zoom_min)
	
	update_speed()


func update_speed() -> void:
	speed = BASE_SPEED * speed_mult / zoom
	accel = BASE_ACCEL / zoom


func change_speed_mult(amount: float) -> void:
	speed_mult += amount

func set_move_vec(vector: Vector2) -> void:
	move_vector = vector

func move_cam_by(vector: Vector2) -> void:
	position += vector


func handle_smooth_zoom(delta: float) -> void:
	camera.zoom += Vector2(zoom - camera.zoom.x, zoom - camera.zoom.x) * min(delta*20,1)
