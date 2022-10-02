extends BaseController


class_name UserController


var _selected_tile: Tile = null


func on_tile_pressed(tile: Tile) -> void:
	if _selected_tile:
		_selected_tile.set_unclicked()
	
	if _selected_tile && _try_move_bug(_selected_tile, tile):
		_selected_tile = null
	else:
		_selected_tile = tile
		_selected_tile.set_clicked()


func _try_move_bug(old_tile: Tile, new_tile: Tile) -> bool:
	var bug: Bug = old_tile.bug()
	if !bug or bug.team() != _team:
		return false
	
	old_tile.remove_bug()
	new_tile.add_bug(bug)
	return true
