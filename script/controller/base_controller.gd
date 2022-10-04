class_name BaseController
extends Node


signal turn_ended


var team: int = -1 setget , get_team


func init(bug_team: int) -> BaseController:
	self.team = bug_team
	return self


func before_turn() -> void:
	pass


func process_turn(_delta: float) -> void:
	pass


func after_turn() -> void:
	pass


func on_tile_pressed(_tile: Tile) -> void:
	pass


func get_team() -> int:
	return team
