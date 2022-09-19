extends StaticBody


class_name Tile


export (NodePath) onready var _shape = get_node(_shape) as CollisionShape


func init(position: Vector3) -> void:
	self.transform.origin = position


func length() -> float:
	return _shape.shape.extents.x


func width() -> float:
	return _shape.shape.extents.y


func height() -> float:
	return _shape.shape.extents.z
