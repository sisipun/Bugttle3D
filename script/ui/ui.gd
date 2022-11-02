class_name Ui
extends Control


export (NodePath) onready var _current_level = get_node(_current_level) as BaseLevel
export (NodePath) onready var _game_over_title = get_node(_game_over_title) as Label
export (NodePath) onready var _skill_icon = get_node(_skill_icon) as TextureRect
export (NodePath) onready var _bug_info = get_node(_bug_info) as BugInfo
export (NodePath) onready var _tile_info = get_node(_tile_info) as TileInfo


func _ready() -> void:
	assert(_current_level.connect("level_started", self, "_on_level_started") == OK)
	assert(_current_level.connect("level_finished", self, "_on_level_finihsed") == OK)


func set_skill_icon(icon: Texture) -> void:
	_game_over_title.hide()
	_skill_icon.texture = icon


func show_bug(bug: Bug) -> void:
	_bug_info.show_bug(bug)


func show_tile(tile: Tile) -> void:
	_tile_info.show_tile(tile)


func _on_level_started() -> void:
	_game_over_title.hide()

func _on_level_finihsed(winner: int) -> void:
	_game_over_title.show()
	_game_over_title.text = "Game over. Team %s won." % Team.names[winner]
