class_name Tile
extends StaticBody


signal pressed(tile)


export (NodePath) onready var _shape = get_node(_shape) as CollisionShape
export (NodePath) onready var _body = get_node(_body) as MeshInstance
export (Material) var _clicked_material

var bug: Bug = null setget add_bug, get_bug
var cost: int = 0 setget , get_cost

var _x: int = 0
var _y: int = 0
var _material: Material = null


func init(x: int, y: int, type: TileType, position: Vector3) -> Tile:
	self.transform.origin = position
	self._x = x
	self._y = y
	self.cost = type.cost
	self._material = type.material
	self.set_unclicked()
	return self


func length() -> float:
	return _shape.shape.extents.x * 2


func width() -> float:
	return _shape.shape.extents.y * 2


func height() -> float:
	return _shape.shape.extents.z * 2


func get_cost() -> int:
	return cost


func get_bug() -> Bug:
	return bug


func has_bug() -> bool:
	return bug != null


func add_bug(new_bug: Bug) -> void:
	bug = new_bug
	bug.transform.origin = transform.origin + Vector3(0, height() / 2, 0)
	assert(bug.connect("dead", self, "_on_bug_dead") == OK)


func remove_bug() -> void:
	bug.disconnect("dead", self, "_on_bug_dead")
	bug = null


func set_clicked() -> void:
	_body.set_material_override(_clicked_material)


func set_unclicked() -> void:
	_body.set_material_override(_material)


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
