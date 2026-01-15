class_name Player
extends CharacterBody2D


var BASE_SPEED = 300
var speed_mult = 1
var speed = BASE_SPEED * speed_mult

var accel = 1000

var move_vector: Vector2 = Vector2.ZERO

func _process(_delta: float) -> void:
	move_and_slide()

func _physics_process(delta: float) -> void:
	velocity.x = move_toward(velocity.x, speed * move_vector.x, delta*accel)
	velocity.y = move_toward(velocity.y, speed * move_vector.y, delta*accel)

func change_mult(amount) ->void:
	speed_mult += amount

func set_move_vec(vector: Vector2) -> void:
	move_vector = vector
