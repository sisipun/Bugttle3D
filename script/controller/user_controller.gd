class_name UserController
extends BaseController


export (NodePath) onready var _ui = get_node(_ui) as Ui


var _hovered_tile: Tile = null
var _selected_tile: Tile = null
var _selected_bug: Bug = null
var _selected_skill: Skill = null
var _skill_possible_targets: Array = []


func before_turn() -> void:
	for tile in _field.tiles:
		assert(tile.connect("pressed", self, "_on_tile_pressed", [tile]) == OK)
		assert(tile.connect("hovered", self, "_on_tile_hovered", [tile]) == OK)


func process_turn(_delta: float) -> void:
	if Input.is_action_just_pressed("controller_cancel"):
		_select_tile(null)
	if Input.is_action_just_pressed("controller_end_turn"):
		emit_signal("turn_ended")
	if Input.is_action_just_pressed("controller_next_skill") and _selected_bug:
		var skills: Array = _selected_bug.skills
		var selected_skill_index: int = _selected_bug.skills.find(_selected_skill)
		var next_skill_index: int = selected_skill_index + 1 if selected_skill_index + 1 < len(skills) else 0
		_select_skill(skills[next_skill_index])
		


func after_turn() -> void:
	for tile in _field.tiles:
		tile.disconnect("pressed", self, "_on_tile_pressed")


func _on_tile_pressed(tile: Tile) -> void:
	if _selected_tile:
		_selected_tile.set_default_material()
	
	if !_selected_tile or !_selected_bug or !_selected_skill:
		_select_tile(tile)
		return
	
	if (
		_selected_bug.team == team 
		and _selected_skill.execute(_selected_bug, tile, _field)
	):
		_select_tile(null)
	else:
		_select_tile(tile)


func _on_tile_hovered(tile: Tile) -> void:
	print("hover: (", tile.x, " - ", tile.y, ")")
	pass


func _select_tile(tile: Tile) -> void:
	if _selected_tile:
		_selected_tile.set_default_material()
	
	_selected_tile = tile
	_select_bug(_selected_tile.bug if _selected_tile else null)
	if _selected_tile:
		_selected_tile.set_clicked_material()


func _select_bug(bug: Bug) -> void:
	_selected_bug = bug
	_select_skill(_selected_bug.skills[0] if _selected_bug and _selected_bug.team == team else null)


func _select_skill(skill: Skill) -> void:
	if _selected_skill:
		for tile in _skill_possible_targets:
			tile.set_default_material()
		_skill_possible_targets = []
		_ui.set_skill_icon(null)
		_selected_skill = null
	
	_selected_skill = skill
	if _selected_skill:
		_skill_possible_targets = _selected_skill.get_possible_targets(_selected_bug, _field)
		for tile in _skill_possible_targets:
			tile.set_skill_material()
		_ui.set_skill_icon(_selected_skill.icon)
