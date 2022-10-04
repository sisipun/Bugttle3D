class_name MainCamera
extends Camera


export(float) var movement_speed = 20.0
export(float) var mouse_sensitivity = 20.0
export(float) var wheel_sensitivity = 50.0

var mouse_movement: Vector2 = Vector2.ZERO
var pitch: float = 0
var yaw: float = 0


func _ready() -> void:
	set_rotation(Vector3(0, 0, 0))


func _process(delta: float) -> void:
	var movement_direction = Vector2.ZERO
	var zoom_direction = 0
	
	if Input.is_action_pressed("camera_rotation"):
		pitch = fmod(pitch - mouse_movement.x * mouse_sensitivity * delta, 360)
		yaw = max(min(yaw - mouse_movement.y * mouse_sensitivity * delta, 0), -90)
		set_rotation(Vector3(deg2rad(yaw), deg2rad(pitch), 0))
	if Input.is_action_pressed("camera_forward"):
		movement_direction.y -= 1
	if Input.is_action_pressed("camera_back"):
		movement_direction.y += 1
	if Input.is_action_pressed("camera_right"):
		movement_direction.x += 1
	if Input.is_action_pressed("camera_left"):
		movement_direction.x -= 1
	if Input.is_action_just_released("camera_zoom_in"):
		zoom_direction -= 1
	if Input.is_action_just_released("camera_zoom_out"):
		zoom_direction += 1
	
	if movement_direction != Vector2.ZERO:
		movement_direction = movement_direction.normalized()
	
	var forward = Vector3(transform.basis.z.x, 0, transform.basis.z.z).normalized()
	var right = Vector3(transform.basis.x.x, 0, transform.basis.x.z).normalized()
	var relative_move_direction = (forward * movement_direction.y + right * movement_direction.x)
	var relative_zoom_direction = transform.basis.z * zoom_direction
	
	transform.origin += relative_move_direction * movement_speed * delta
	transform.origin += relative_zoom_direction * wheel_sensitivity * delta
	
	mouse_movement = Vector2.ZERO


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_movement = event.relative
