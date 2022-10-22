class_name Ui
extends Control


export (NodePath) onready var _skill_icon = get_node(_skill_icon) as TextureRect
export (NodePath) onready var _bug_info = get_node(_bug_info) as BugInfo


func set_skill_icon(icon: Texture) -> void:
	_skill_icon.texture = icon


func show_bug(bug: Bug) -> void:
	_bug_info.show_bug(bug)
