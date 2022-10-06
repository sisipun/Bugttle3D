class_name UserController
extends BaseController


var _selected_tile: Tile = null


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
	
	if _selected_tile && _try_bug_action(_selected_tile, tile):
		_selected_tile = null
	else:
		_selected_tile = tile
		_selected_tile.set_clicked()


func _try_bug_action(old_tile: Tile, new_tile: Tile) -> bool:
	var old_tile_bug: Bug = old_tile.bug
	var new_tile_bug: Bug = new_tile.bug
	if !old_tile_bug or old_tile_bug.team != team:
		return false
	
	return _try_bug_move(old_tile, old_tile_bug, new_tile) if !new_tile_bug else _try_bug_attack(old_tile_bug, new_tile_bug)


func _try_bug_move(old_tile: Tile, old_tile_bug: Bug, new_tile: Tile):
	if PathFinder.find_path(old_tile, new_tile).value == []:
		return false
	
	old_tile.remove_bug()
	new_tile.add_bug(old_tile_bug)
	return true


func _try_bug_attack(old_tile_bug: Bug, new_tile_bug: Bug):
	if new_tile_bug.team == team:
		return false
	
	old_tile_bug.attack(new_tile_bug)
	return true


func _cancel() -> void:
	if _selected_tile:
		_selected_tile.set_unclicked()
	
	_selected_tile = null
