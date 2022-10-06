class_name PathInfo
extends Node


var value: Array = [] setget , get_value


func _init(path: Array):
	self.value = path


func get_value() -> Array:
	return value
