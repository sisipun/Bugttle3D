class_name BaseLevel
extends Node


export (NodePath) onready var _field = get_node(_field) as Field
export (Team.Side) var _first_team: int = Team.Side.RED

var _team_to_controller: Dictionary = {}
var _current_team: int = -1
var _current_controller: BaseController = null


func init() -> void:
	_field.init()
	_init_teams()
	_init_bugs()
	_start_turn(_first_team)


func _start_turn(team: int) -> void:
	_current_team = team
	_current_controller = _team_to_controller[_current_team]
	assert(_current_controller.connect("turn_ended",self, "_on_turn_ended") == OK)
	_current_controller.before_turn()


func _init_teams() -> void:
	pass


func _init_bugs() -> void:
	pass


func _process(delta: float) -> void:
	if _current_controller:
		_current_controller.process_turn(delta)


func _end_turn() -> void:
	_current_controller.after_turn()
	_current_controller.disconnect("turn_ended", self, "_on_turn_ended")
	_start_turn(1 - _current_team)


func _on_turn_ended() -> void:
	_end_turn()
