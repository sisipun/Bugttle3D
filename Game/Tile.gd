extends StaticBody


class_name Tile


signal pressed(tile)


export (NodePath) onready var _shape = get_node(_shape) as CollisionShape
export (NodePath) onready var _body = get_node(_body) as MeshInstance
export (Material) var _clicked_material


var _x: int = 0
var _y: int = 0
var _cost: int = 0
var _material: Material = null
var _bug: Bug = null


func init(x: int, y: int, data: TileData, position: Vector3) -> Tile:
	self.transform.origin = position
	self._x = x
	self._y = y
	self._cost = data.cost
	self._material = data.material
	self.set_unclicked()
	return self


func length() -> float:
	return _shape.shape.extents.x * 2


func width() -> float:
	return _shape.shape.extents.y * 2


func height() -> float:
	return _shape.shape.extents.z * 2


func cost() -> int:
	return _cost


func bug() -> Bug:
	return self._bug


func has_bug() -> bool:
	return self._bug != null


func add_bug(bug: Bug) -> void:
	self._bug = bug
	self._bug.transform.origin = transform.origin + Vector3(0, height() / 2, 0)


func remove_bug() -> void:
	self._bug = null


func set_clicked() -> void:
	_body.set_material_override(_clicked_material)


func set_unclicked() -> void:
	_body.set_material_override(_material)


func _on_event(
	_camera: Node, 
	event: InputEvent, 
	_position: Vector3, 
	_normal: Vector3, 
	_shape_idx: int
) -> void:
	if (
		event is InputEventMouseButton and event.is_pressed() 
		and event.button_index == BUTTON_LEFT
	):
		emit_signal("pressed", self)
