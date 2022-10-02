extends Spatial


class_name Level


export (PackedScene) var _tile_scene = _tile_scene as PackedScene
export (PackedScene) var _bug_scene = _bug_scene as PackedScene
export (Array, Resource) var _tile_types
export (Array, Resource) var _bug_types
export (int) var _size = 10
export (int) var _bugs_count = 3


var _map: Array = []
var _team_to_controller: Dictionary = {}
var _current_team: int = -1


func _ready() -> void:
	for x in range(_size):
		for y in range(_size):
			var tile: Tile = _add_tile()
			var offset: float = (_size - 1.0) / 2.0
			var tile_type_index = randi() % len(_tile_types)
			tile = tile.init(
				x, 
				y, 
				_tile_types[tile_type_index], 
				Vector3((x - offset) * tile.length(), 0, (y - offset) * tile.width())
			)
	
	_team_to_controller[Team.RED] = UserController.new().init(Team.RED)
	for i in _bugs_count: 
		var bug: Bug = _add_bug().init(Team.RED, _bug_types[randi() % len(_bug_types)])
		var bug_tile: Tile = _map[i];
		bug_tile.add_bug(bug)
	
	_team_to_controller[Team.BLUE] = UserController.new().init(Team.BLUE)
	for i in _bugs_count: 
		var bug: Bug = _add_bug().init(Team.BLUE, _bug_types[randi() % len(_bug_types)])
		var bug_tile: Tile = _map[-i - 1];
		bug_tile.add_bug(bug)
	
	start_turn(Team.RED)


func start_turn(team: int) -> void:
	_current_team = team
	var new_controller = _team_to_controller[_current_team] 
	new_controller.start_turn()
	for tile in _map:
		assert(tile.connect("pressed", new_controller, "on_tile_pressed") == OK)


func end_turn() -> void:
	var current_controller: BaseController = _team_to_controller[_current_team]
	current_controller.end_turn()
	for tile in _map:
		assert(tile.disconnect("pressed", current_controller, "on_tile_pressed") == OK)
	start_turn(1 - _current_team)


func _add_tile() -> Tile:
	var tile: Tile = _tile_scene.instance()
	add_child(tile)
	_map.append(tile)
	return tile


func _add_bug() -> Bug:
	var bug: Bug = _bug_scene.instance()
	add_child(bug)
	return bug
