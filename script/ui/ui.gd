class_name Ui
extends Control


export (NodePath) onready var _skill_icon = get_node(_skill_icon) as TextureRect


func set_skill_icon(icon: Texture) -> void:
	_skill_icon.texture = icon
