extends Spatial


class_name Level


export (PackedScene) var _tile_scene = _tile_scene as PackedScene
export (Array, Resource) var _tile_types 
export (int) var size = 5


var _map: Array = []
var _selected_tile: Tile = null


func _ready() -> void:
	for x in range(size):
		for y in range(size):
			var tile: Tile = _add_tile()
			var offset: float = (size - 1.0) / 2.0
			var tile_type_index = randi() % len(_tile_types)
			tile.init(
				x, 
				y, 
				_tile_types[tile_type_index], 
				Vector3((x - offset) * tile.length(), 0, (y - offset) * tile.width())
			)


func _add_tile() -> Tile:
	var tile: Tile = _tile_scene.instance()
	add_child(tile)
	_map.append(tile)
	assert(tile.connect("pressed", self, "_on_tile_pressed") == OK)
	return tile


func _on_tile_pressed(x, y) -> void:
	if _selected_tile:
		_selected_tile.set_unclicked()
	
	_selected_tile = _map[x * size + y]
	_selected_tile.set_clicked()
