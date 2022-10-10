class_name UserController
extends BaseController


var _selected_tile: Tile = null
var _selected_bug: Bug = null
var _selected_skill: Skill = null


func before_turn() -> void:
	for tile in _field.tiles:
		assert(tile.connect("pressed", self, "_on_tile_pressed", [tile]) == OK)


func process_turn(_delta: float) -> void:
	if Input.is_action_just_pressed("controller_cancel"):
		_cancel()
	if Input.is_action_just_pressed("controller_end_turn"):
		emit_signal("turn_ended")


func after_turn() -> void:
	for tile in _field.tiles:
		tile.disconnect("pressed", self, "_on_tile_pressed")


func _on_tile_pressed(tile: Tile) -> void:
	if _selected_tile:
		_selected_tile.set_unclicked()
	
	if !_selected_tile or !_selected_bug or !_selected_skill:
		_select(tile)
		return
	
	if (
		_selected_bug.team == team 
		and _selected_skill.execute(_selected_bug, tile, _field)
	):
		_cancel()
	else:
		_select(tile)


func _cancel() -> void:
	if _selected_tile:
		_selected_tile.set_unclicked()
	
	_select(null)


func _select(tile: Tile) -> void:
	_selected_tile = tile
	_selected_bug = tile.bug if tile else null
	_selected_skill = _selected_bug.skills[0] if _selected_bug and _selected_bug.team == team else null
	if tile:
		_selected_tile.set_clicked()
