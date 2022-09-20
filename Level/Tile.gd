extends StaticBody


class_name Tile


signal pressed(x, y)


export (NodePath) onready var _shape = get_node(_shape) as CollisionShape
export (NodePath) onready var _body = get_node(_body) as MeshInstance
export (Material) var _material
export (Material) var _clicked_material


var _x = 0
var _y = 0


func init(x: int, y: int, position: Vector3) -> void:
	self.transform.origin = position
	self._x = x
	self._y = y
	self.set_unclicked()


func length() -> float:
	return _shape.shape.extents.x * 2


func width() -> float:
	return _shape.shape.extents.y * 2


func height() -> float:
	return _shape.shape.extents.z * 2


func set_clicked():
	_body.set_material_override(_clicked_material)


func set_unclicked():
	_body.set_material_override(_material)


func _on_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("pressed", _x, _y)
