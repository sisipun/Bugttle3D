class_name Level
extends Spatial


export (NodePath) onready var _field = get_node(_field) as Field
export (NodePath) onready var _red_controller = get_node(_red_controller) as BaseController
export (NodePath) onready var _blue_controller = get_node(_blue_controller) as BaseController

export (Array, Resource) var _tile_types: Array = []
export (Array, Resource) var _bug_types: Array = []
export (int) var _bugs_count: int = 3

var _team_to_controller: Dictionary = {}
var _current_team: int = -1
var _current_controller: BaseController = null


func _ready() -> void:
	var tiles: Array = []
	for _i in range(_field.width * _field.height):
		tiles.append(_tile_types[randi() % len(_tile_types)])
	_field.init(tiles)
	
	
	_team_to_controller[Team.Side.RED] = _red_controller
	for i in _bugs_count: 
		_field.add_bug(
			i / _field.width, 
			i % _field.height, 
			Team.Side.RED, 
			_bug_types[randi() % len(_bug_types)]
		)
	
	_team_to_controller[Team.Side.BLUE] = _blue_controller
	for i in _bugs_count:
		_field.add_bug(
			_field.width - 1 - int(i / _field.width), 
			i % _field.height, 
			Team.Side.BLUE, 
			_bug_types[randi() % len(_bug_types)]
		)
	
	start_turn(Team.Side.RED)


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
