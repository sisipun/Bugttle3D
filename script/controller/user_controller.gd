class_name UserController
extends BaseController


export (NodePath) onready var _ui = get_node(_ui) as Ui


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
	if Input.is_action_just_pressed("controller_next_skill") and _selected_bug:
		var skills: Array = _selected_bug.skills
		var selected_skill_index: int = _selected_bug.skills.find(_selected_skill)
		_select_skill(skills[selected_skill_index + 1 if selected_skill_index + 1 < len(skills) else 0])
		


func after_turn() -> void:
	for tile in _field.tiles:
		tile.disconnect("pressed", self, "_on_tile_pressed")


func _on_tile_pressed(tile: Tile) -> void:
	if _selected_tile:
		_selected_tile.set_unclicked()
	
	if !_selected_tile or !_selected_bug or !_selected_skill:
		_select_tile(tile)
		return
	
	if (
		_selected_bug.team == team 
		and _selected_skill.execute(_selected_bug, tile, _field)
	):
		_cancel()
	else:
		_select_tile(tile)


func _cancel() -> void:
	if _selected_tile:
		_selected_tile.set_unclicked()
	
	_select_tile(null)


func _select_tile(tile: Tile) -> void:
	_selected_tile = tile
	_select_bug(_selected_tile.bug if _selected_tile else null)
	
	if _selected_tile:
		_selected_tile.set_clicked()


func _select_bug(bug: Bug) -> void:
	_selected_bug = bug
	_select_skill(_selected_bug.skills[0] if _selected_bug and _selected_bug.team == team else null)


func _select_skill(skill: Skill) -> void:
	_selected_skill = skill
	_ui.set_skill_icon(_selected_skill.icon if _selected_skill else null)
