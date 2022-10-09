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
	
	if !_selected_tile or !_selected_tile.bug:
		_selected_tile = tile
		_selected_tile.set_clicked()
		return
	
	var selected_bug: Bug = _selected_tile.bug
	# todo select skill
	var selected_skill = selected_bug.skills[0]
	
	if selected_skill.execute(selected_bug, tile, _field):
		_selected_tile = null
	else:
		_selected_tile = tile
		_selected_tile.set_clicked()


func _cancel() -> void:
	if _selected_tile:
		_selected_tile.set_unclicked()
	
	_selected_tile = null
