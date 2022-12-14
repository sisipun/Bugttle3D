class_name Field
extends Node


export (PackedScene) var _tile_scene = _tile_scene as PackedScene
export (PackedScene) var _bug_scene = _bug_scene as PackedScene

export (Resource) var _biome = _biome as FieldBiomeType

export (int) var width: int = 0
export (int) var height: int = 0

var tiles: Array = []
var team_bugs: Dictionary = {}


func init() -> Field:
	self.tiles.resize(width * height)
	for x in range(width):
		for y in range(height):
			_add_tile(x, y, _biome.tile_types[randi() % len(_biome.tile_types)])
	return self


func clear() -> void:
	for bugs in team_bugs.values():
		if bugs:
			for bug in bugs:
				bug.queue_free()
			bugs.clear()
	team_bugs.clear()
	
	for tile in tiles:
		tile.queue_free()
	tiles.clear()


func get_tile(position: Vector2) -> Tile:
	return tiles[position.x * height + position.y]


func get_bug_tile(bug: Bug) -> Tile:
	return tiles[bug.get_x() * height + bug.get_y()]


func add_bug(x: int, y: int, team: int, type: BugType) -> void:
	var bug: Bug = _bug_scene.instance()
	add_child(bug)
	assert(bug.connect("dead", self, "_on_bug_dead", [bug]) == OK)
	tiles[x * height + y].bug = bug.init(x, y, team, type)
	if team in team_bugs:
		team_bugs[bug.team].append(bug)
	else:
		team_bugs[bug.team] = [bug]


func _add_tile(x: int, y: int, type: TileType):
	var tile: Tile = _tile_scene.instance()
	add_child(tile)
	tiles[x * height + y] = tile.init(x, y, width, height, type)


func _on_bug_dead(bug: Bug) -> void:
	team_bugs[bug.team].erase(bug)
	bug.queue_free()
