extends Camera


export var speed = 1


var velocity = Vector3.ZERO



func _process(delta: float) -> void:
	var direction: Vector3 = Vector3.ZERO
	
	if Input.is_action_pressed("camera_forward"):
		direction.z -= 1
	if Input.is_action_pressed("camera_back"):
		direction.z += 1
	if Input.is_action_pressed("camera_right"):
		direction.x += 1
	if Input.is_action_pressed("camera_left"):
		direction.x -= 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	velocity = direction * speed
	transform.origin += velocity


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pass
		# TODO camra rotation
		# look_at(project_ray_origin(event.position) + project_ray_normal(event.position), Vector3.UP)
