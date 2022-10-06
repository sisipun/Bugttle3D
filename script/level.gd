class_name Level
extends Spatial


export (PackedScene) var _field_scene = _field_scene as PackedScene
export (int) var _field_size = 10
export (Array, Resource) var _tile_types
export (Array, Resource) var _bug_types
export (int) var _bugs_count = 3

var _field: Field = null
var _team_to_controller: Dictionary = {}
var _current_team: int = -1
var _current_controller: BaseController = null


func _ready() -> void:
	var tiles: Array = []
	for _i in range(_field_size * _field_size):
		tiles.append(_tile_types[randi() % len(_tile_types)])
	_field = _field_scene.instance().init(Vector2(_field_size, _field_size), tiles)
	add_child(_field)
	
	_team_to_controller[Team.RED] = UserController.new().init(Team.RED, _field)
	for i in _bugs_count: 
		_field.add_bug(
			Vector2(int(i / _field_size), i % _field_size), 
			Team.RED, 
			_bug_types[randi() % len(_bug_types)]
		)
	
	_team_to_controller[Team.BLUE] = UserController.new().init(Team.BLUE, _field)
	for i in _bugs_count:
		_field.add_bug(
			Vector2(_field_size - 1 - int(i / _field_size), i % _field_size), 
			Team.BLUE, 
			_bug_types[randi() % len(_bug_types)]
		)
	
	start_turn(Team.RED)


func _process(delta: float) -> void:
	_current_controller.process_turn(delta)


func start_turn(team: int) -> void:
	_current_team = team
	_current_controller = _team_to_controller[_current_team]
	assert(_current_controller.connect("turn_ended",self, "_on_turn_ended") == OK)
	_current_controller.before_turn()


func end_turn() -> void:
	_current_controller.after_turn()
	_current_controller.disconnect("turn_ended", self, "_on_turn_ended")	
	start_turn(1 - _current_team)


func _on_turn_ended() -> void:
	end_turn()
