class_name BugInfo
extends Control


export (NodePath) onready var _name = get_node(_name) as Label
export (NodePath) onready var _health = get_node(_health) as Label
export (NodePath) onready var _speed = get_node(_speed) as Label
export (NodePath) onready var _power = get_node(_power) as Label
export (NodePath) onready var _range = get_node(_range) as Label


func show_bug(bug: Bug) -> void:
	if bug:
		visible = true
		_name.text = str(bug.type.name)
		_health.text = "%d/%d" % [bug.health, bug.type.health] 
		_speed.text = "%d/%d" % [bug.move_range, bug.type.move_range]
		_power.text = str(bug.attack_power)
		_range.text = "%d/%d" % [bug.attack_range, bug.type.attack_range]
	else:
		visible = false
