class_name PathInfo
extends Node


var value: Array = [] setget , get_value


func _init(value: Array):
	self.value = value


func get_value() -> Array:
	return value
