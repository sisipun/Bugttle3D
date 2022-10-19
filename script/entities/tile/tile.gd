class_name Tile
extends StaticBody


signal pressed
signal hovered


var bug: Bug = null setget set_bug, get_bug
var cost: int = 0 setget , get_cost
var x: int = 0 setget , get_x
var y: int = 0 setget , get_y
var position: Vector2 setget , get_position

var _material: Material = null


func init(
	_x: int,
	_y: int, 
	field_width: int, 
	field_height: int,
	type: TileType
) -> Tile:
	self.x = _x
	self.y = _y
	self.cost = type.cost
	self._material = type.material
	self.transform.origin = Vector3(
		(x - (field_width - 1.0) / 2.0) * length(), 
		0, 
		(y - (field_height - 1.0) / 2.0) * width()
	)
	self.set_body_default_material()
	self.set_top_body_default_material()
	return self


func length() -> float:
	return $Shape.shape.extents.x * 2


func width() -> float:
	return $Shape.shape.extents.y * 2


func height() -> float:
	return $Shape.shape.extents.z * 2


func get_x() -> int:
	return x


func get_y() -> int:
	return y


func get_position() -> Vector2:
	return Vector2(x, y)


func get_cost() -> int:
	return cost


func get_bug() -> Bug:
	return bug


func has_bug() -> bool:
	return bug != null


func set_bug(_bug: Bug) -> void:
	bug = _bug
	bug.transform.origin = transform.origin + Vector3(0, height() / 2, 0)
	assert(bug.connect("dead", self, "_on_bug_dead") == OK)
	bug.set_position(x, y)


func remove_bug() -> void:
	bug.disconnect("dead", self, "_on_bug_dead")
	bug = null


func set_body_material(material: Material) -> void:
	$Body.set_material_override(material)


func set_body_default_material() -> void:
	$Body.set_material_override(_material)


func set_top_body_material(material: Material) -> void:
	$Body/TopBody.visible = true
	$Body/TopBody.set_material_override(material)


func set_top_body_default_material() -> void:
	$Body/TopBody.visible = false


func _on_bug_dead() -> void:
	bug = null


func _on_event(
	_camera: Node, 
	event: InputEvent, 
	_position: Vector3, 
	_normal: Vector3, 
	_shape_idx: int
) -> void:
	if (
		event is InputEventMouseButton 
		and event.is_pressed() 
		and event.button_index == BUTTON_LEFT
	):
		emit_signal("pressed")
	
	if event is InputEventMouseMotion:
		emit_signal("hovered")
