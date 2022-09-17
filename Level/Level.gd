extends Spatial


class_name Level


export (PackedScene) var _tile_scene = _tile_scene as PackedScene


func _ready() -> void:
	var tile: Tile = _tile_scene.instance()
	add_child(tile)
