class_name Ui
extends Control


export (NodePath) onready var _skill_icon = get_node(_skill_icon) as TextureRect
export (NodePath) onready var _bug_info = get_node(_bug_info) as BugInfo
export (NodePath) onready var _tile_info = get_node(_tile_info) as TileInfo


func set_skill_icon(icon: Texture) -> void:
	_skill_icon.texture = icon


func show_bug(bug: Bug) -> void:
	_bug_info.show_bug(bug)


func show_tile(tile: Tile) -> void:
	_tile_info.show_tile(tile)
