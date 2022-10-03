extends BaseController


class_name UserController


var _selected_tile: Tile = null


func process_turn(_delta: float) -> void:
	if Input.is_action_just_pressed("controller_cancel"):
		_cancel()


func on_tile_pressed(tile: Tile) -> void:
	if _selected_tile:
		_selected_tile.set_unclicked()
	
	if _selected_tile && _try_bug_action(_selected_tile, tile):
		_selected_tile = null
	else:
		_selected_tile = tile
		_selected_tile.set_clicked()


func _try_bug_action(old_tile: Tile, new_tile: Tile) -> bool:
	var old_tile_bug: Bug = old_tile.bug()
	var new_tile_bug: Bug = new_tile.bug()
	if !old_tile_bug or old_tile_bug.team() != _team:
		return false
	
	if !new_tile_bug:
		old_tile.remove_bug()
		new_tile.add_bug(old_tile_bug)
		return true
	
	if new_tile_bug.team() == _team:
		return false
	
	old_tile_bug.attack(new_tile_bug)
	return true


func _cancel() -> void:
	if _selected_tile:
		_selected_tile.set_unclicked()
	
	_selected_tile = null
