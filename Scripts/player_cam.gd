extends Camera2D


const BASE_SPEED: float = 500.0
const BASE_ACCEL: float = 1000.0

var world_rect: Rect2 = Rect2(0,0,0,0)
var velocity: Vector2 = Vector2.ZERO
var move_vector: Vector2 = Vector2.ZERO
var speed_mult: float = 1.0
var speed: float = BASE_SPEED * speed_mult
var accel: float = BASE_ACCEL * zoom_amount
var zoom_amount: float = 1
var zoom_max: float = .2
var zoom_min: float = 4


func _ready() -> void:
	Globals.set_camera(self)


func _process(delta: float) -> void:
	
	handle_smooth_zoom(delta)
	position += delta * velocity
	position = position.clamp(Vector2(0,0), world_rect.end)


func _physics_process(delta: float) -> void:
	
	if world_rect == Rect2(0,0,0,0):
		world_rect = Globals.get_world_rect()
		#print(world_rect)
	
	if move_vector.length() != 0:
		velocity.x = move_toward(velocity.x, move_vector.x*speed, delta*accel*5)
		velocity.y = move_toward(velocity.y, move_vector.y*speed, delta*accel*5)
		#print(velocity, speed, delta, accel)
	else:
		#print('stop')
		velocity.x = move_toward(velocity.x, 0, delta*accel)
		velocity.y = move_toward(velocity.y, 0, delta*accel)


func zoom_in(percent_amount: float) -> void:
	
	zoom_amount *= percent_amount
	zoom_amount = clampf(zoom_amount, zoom_max, zoom_min)
	
	update_speed()


func zoom_out(percent_amount: float) -> void:
	
	zoom_amount /= percent_amount
	zoom_amount = clampf(zoom_amount, zoom_max, zoom_min)
	
	update_speed()


func update_speed() -> void:
	speed = BASE_SPEED * speed_mult / zoom_amount
	accel = BASE_ACCEL / zoom_amount


func change_speed_mult(amount: float) -> void:
	speed_mult += amount


func set_move_vec(vector: Vector2) -> void:
	move_vector = vector


func move_cam_by(vector: Vector2) -> void:
	position += vector


func handle_smooth_zoom(delta: float) -> void:
	#print(zoom_amount)
	zoom += Vector2(zoom_amount - zoom.x, zoom_amount - zoom.x) * min(delta*20,1)
