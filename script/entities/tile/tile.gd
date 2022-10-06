class_name Tile
extends StaticBody


signal pressed(tile)


export (Material) var _clicked_material

var bug: Bug = null setget add_bug, get_bug
var cost: int = 0 setget , get_cost
var position: Vector2 = Vector2.ZERO setget , get_position

var _material: Material = null


func init(
	new_position: Vector2, 
	field_size: Vector2, 
	type: TileType
) -> Tile:
	self.position = new_position
	self.cost = type.cost
	self._material = type.material
	self.transform.origin = Vector3(
		(position.x - (field_size.x - 1.0) / 2.0) * length(), 
		0, 
		(position.y - (field_size.y - 1.0) / 2.0) * width()
	)
	self.set_unclicked()
	return self


func length() -> float:
	return $Shape.shape.extents.x * 2


func width() -> float:
	return $Shape.shape.extents.y * 2


func height() -> float:
	return $Shape.shape.extents.z * 2


func get_position() -> Vector2:
	return position


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
	$Body.set_material_override(_clicked_material)


func set_unclicked() -> void:
	$Body.set_material_override(_material)


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
