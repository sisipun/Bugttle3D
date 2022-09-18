extends Spatial


class_name Level


export (PackedScene) var _tile_scene = _tile_scene as PackedScene
export (int) var size = 5


var _map: Array = [] 


func _ready() -> void:
	for i in range(size):
		for j in range(size):
			var tile: Tile = _tile_scene.instance()
			var offset: float = (size - 1.0) / 2.0
			tile.init(Vector3((i - offset) * tile.length(), 0, (j - offset) * tile.width()))
			_map.append(tile)
			add_child(tile)
