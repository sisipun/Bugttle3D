class_name Level
extends Spatial


export (PackedScene) var _tile_scene = _tile_scene as PackedScene
export (PackedScene) var _bug_scene = _bug_scene as PackedScene
export (Array, Resource) var _tile_types
export (Array, Resource) var _bug_types
export (int) var _size = 10
export (int) var _bugs_count = 3

var _map: Array = []
var _team_to_controller: Dictionary = {}
var _current_team: int = -1
var _current_controller: BaseController = null


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
				Vector3(
					(x - offset) * tile.length(), 
					0, 
					(y - offset) * tile.width()
				)
			)
	
	_team_to_controller[Team.RED] = UserController.new().init(Team.RED)
	for i in _bugs_count: 
		var bug_type = _bug_types[randi() % len(_bug_types)]
		var bug: Bug = _add_bug().init(Team.RED, bug_type)
		var bug_tile: Tile = _map[i];
		bug_tile.bug = bug
	
	_team_to_controller[Team.BLUE] = UserController.new().init(Team.BLUE)
	for i in _bugs_count:
		var bug_type = _bug_types[randi() % len(_bug_types)]
		var bug: Bug = _add_bug().init(Team.BLUE, bug_type)
		var bug_tile: Tile = _map[-i - 1];
		bug_tile.bug = bug
	
	start_turn(Team.RED)


func _process(delta: float) -> void:
	_current_controller.process_turn(delta)


func start_turn(team: int) -> void:
	_current_team = team
	_current_controller = _team_to_controller[_current_team]
	for tile in _map:
		assert(tile.connect(
			"pressed", 
			_current_controller, 
			"on_tile_pressed",
			[tile]
		) == OK)
	
	assert(_current_controller.connect(
		"turn_ended", 
		self, 
		"_on_turn_ended"
	) == OK)
	_current_controller.before_turn()


func end_turn() -> void:
	_current_controller.after_turn()
	_current_controller.disconnect("turn_ended", self, "_on_turn_ended")	
	for tile in _map:
		tile.disconnect("pressed", _current_controller, "on_tile_pressed")
	start_turn(1 - _current_team)


func _on_bug_dead(bug: Bug) -> void:
	bug.queue_free()


func _on_turn_ended() -> void:
	end_turn()


func _add_tile() -> Tile:
	var tile: Tile = _tile_scene.instance()
	add_child(tile)
	_map.append(tile)
	return tile


func _add_bug() -> Bug:
	var bug: Bug = _bug_scene.instance()
	add_child(bug)
	assert(bug.connect("dead", self, "_on_bug_dead", [bug]) == OK)
	return bug
