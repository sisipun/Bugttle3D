class_name Game
extends Node


export (NodePath) onready var _level = get_node(_level) as BaseLevel


func _ready() -> void:
	assert(_level.connect("level_finished", self, "_on_level_finihsed") == OK)
	_level.init()


func _on_level_finihsed(_winner: int) -> void:
	_level.clear()
	_level.init()
