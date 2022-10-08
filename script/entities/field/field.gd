class_name Field
extends Node


export (PackedScene) var _tile_scene = _tile_scene as PackedScene
export (PackedScene) var _bug_scene = _bug_scene as PackedScene

var width: int = 0 setget , get_width
var height: int = 0 setget , get_height
var tiles: Array = [] setget , get_tiles


func init(new_width: int, new_height: int, tile_types: Array) -> Field:
	self.width = new_width
	self.height = new_height
	self.tiles.resize(width * height)
	for x in range(width):
		for y in range(height):
			_add_tile(x, y, tile_types[x * height + y])
	return self


func get_width() -> int:
	return width


func get_height() -> int:
	return height


func get_tiles() -> Array:
	return tiles


func add_bug(x: int, y: int, team: int, type: BugType) -> void:
	var bug: Bug = _bug_scene.instance()
	add_child(bug)
	assert(bug.connect("dead", self, "_on_bug_dead", [bug]) == OK)
	tiles[x * height + y].bug = bug.init(team, type)


func _add_tile(x: int, y: int, type: TileType):
	var tile: Tile = _tile_scene.instance()
	add_child(tile)
	tiles[x * height + y] = tile.init(x, y, width, height, type)


func _on_bug_dead(bug: Bug) -> void:
	bug.queue_free()
