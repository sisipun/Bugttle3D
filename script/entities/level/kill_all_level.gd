class_name KillAllLevel
extends BaseLevel


export (NodePath) onready var _red_controller = get_node(_red_controller) as BaseController
export (NodePath) onready var _blue_controller = get_node(_blue_controller) as BaseController

export (Array, Resource) var _bug_types: Array = []
export (int) var _init_bugs_count: int = 3


func _init_teams() -> void:
	_team_to_controller[Team.Side.RED] = _red_controller
	_team_to_controller[Team.Side.BLUE] = _blue_controller


func _init_bugs() -> void:
	for i in _init_bugs_count: 
		_field.add_bug(
			i / _field.width, 
			i % _field.height, 
			Team.Side.RED, 
			_bug_types[randi() % len(_bug_types)]
		)
	
	for i in _init_bugs_count:
		_field.add_bug(
			_field.width - 1 - int(i / _field.width), 
			_field.height - 1 - i % _field.height, 
			Team.Side.BLUE, 
			_bug_types[randi() % len(_bug_types)]
		)


func _check_state() -> void:
	for team in _field.team_bugs:
		if _field.team_bugs[team] == []:
			emit_signal("level_finished", 1 - team)
