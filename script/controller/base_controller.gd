class_name BaseController
extends Node


signal turn_ended


export (Team.Side) var team = Team.Side.RED setget , get_team
export (NodePath) onready var _field = get_node(_field) as Field


func init(bug_team: int, field: Field) -> BaseController:
	self.team = bug_team
	self._field = field
	return self


func before_turn() -> void:
	pass


func process_turn(_delta: float) -> void:
	pass


func after_turn() -> void:
	pass


func get_team() -> int:
	return team
