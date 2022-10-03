extends Node


class_name BaseController


var _team: int = -1


func init(team: int) -> BaseController:
	self._team = team
	return self


func start_turn() -> void:
	pass


func process_turn(_delta: float) -> void:
	pass


func end_turn() -> void:
	pass


func on_tile_pressed(_tile: Tile) -> void:
	pass


func team() -> int:
	return _team
