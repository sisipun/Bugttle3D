extends StaticBody


class_name Tile


export (NodePath) onready var _shape = get_node(_shape) as CollisionShape


var _length: float = 1.0
var _height: float = 1.0
var _width: float = 1.0


func _ready() -> void:
	_length = _shape.shape.extents.x
	_height = _shape.shape.extents.y
	_width = _shape.shape.extents.z


func init(position: Vector3) -> void:
	self.transform.origin = position


func length() -> float:
	return _length


func width() -> float:
	return _width


func height() -> float:
	return _height
