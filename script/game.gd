class_name Game
extends Node


export (NodePath) onready var _level = get_node(_level) as BaseLevel


func _ready() -> void:
	_level.init()
