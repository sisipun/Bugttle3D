class_name BaseController
extends Node


# warning-ignore:unused_signal
signal turn_ended


export (NodePath) onready var _field = get_node(_field) as Field

export (Team.Side) var team: int = Team.Side.RED setget , get_team


func before_turn() -> void:
	for tile in _field.tiles:
		var bug: Bug = tile.bug
		if bug and bug.team == team:
			bug.before_turn()
	_before_turn()


func process_turn(delta: float) -> void:
	_process_turn(delta)


func after_turn() -> void:
	for tile in _field.tiles:
		var bug: Bug = tile.bug
		if bug and bug.team == team:
			bug.after_turn()
	_after_turn()


func _before_turn() -> void:
	pass


func _process_turn(_delta: float) -> void:
	pass


func _after_turn() -> void:
	pass


func get_team() -> int:
	return team
