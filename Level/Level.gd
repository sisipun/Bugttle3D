extends Spatial


class_name Level


export (PackedScene) var _tile_scene = _tile_scene as PackedScene
export (PackedScene) var _bug_scene = _bug_scene as PackedScene
export (Array, Resource) var _tile_types
export (Array, Resource) var _bug_types 
export (int) var size = 5


var _map: Array = []
var _selected_tile: Tile = null
var _teams: Array = [0, 1]
var _current_team: int = 0
var _initial_bug_count: int = 3


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
	
	for team in _teams:
		for i in _initial_bug_count: 
			var bug: Bug = _add_bug()
			bug.init(team, _bug_types[randi() % len(_teams)])
			var bug_tile: Tile = _map[-team + pow(-1, team) * i];
			bug.transform.origin = bug_tile.transform.origin + Vector3(0, bug_tile.height() / 2, 0)
	
	_current_team = _teams[0]


func _on_tile_pressed(x, y) -> void:
	if _selected_tile:
		_selected_tile.set_unclicked()
	
	_selected_tile = _map[x * size + y]
	_selected_tile.set_clicked()


func _add_tile() -> Tile:
	var tile: Tile = _tile_scene.instance()
	add_child(tile)
	_map.append(tile)
	assert(tile.connect("pressed", self, "_on_tile_pressed") == OK)
	return tile


func _add_bug() -> Bug:
	var bug: Bug = _bug_scene.instance()
	add_child(bug)
	return bug
