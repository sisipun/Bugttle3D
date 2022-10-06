class_name Field
extends Node


export (PackedScene) var _tile_scene = _tile_scene as PackedScene
export (PackedScene) var _bug_scene = _bug_scene as PackedScene

var size: Vector2 = Vector2.ZERO setget , get_size
var tiles: Array = [] setget , get_tiles


func init(new_size: Vector2, tile_types: Array) -> Field:
	self.size = new_size
	self.tiles.resize(size.x * size.y)
	for x in range(size.x):
		for y in range(size.y):
			_add_tile(Vector2(x, y), tile_types[x * size.y + y])
	return self


func get_size() -> Vector2:
	return size


func get_tiles() -> Array:
	return tiles


func add_bug(position: Vector2, team: int, type: BugType) -> void:
	var bug: Bug = _bug_scene.instance()
	add_child(bug)
	assert(bug.connect("dead", self, "_on_bug_dead", [bug]) == OK)
	tiles[position.x * size.y + position.y].bug = bug.init(team, type)


func _add_tile(position: Vector2, type: TileType):
	var tile: Tile = _tile_scene.instance()
	add_child(tile)
	tiles[position.x * size.y + position.y] = tile.init(position, size, type)


func _on_bug_dead(bug: Bug) -> void:
	bug.queue_free()
