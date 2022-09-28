extends KinematicBody


class_name Bug


export (NodePath) onready var _shape = get_node(_shape) as CollisionShape
export (NodePath) onready var _body = get_node(_body) as MeshInstance


var _max_health = 0
var _health = 0
var _attack_power = 0
var _attack_range = 0


func init(data: BugData) -> void:
	self._max_health = data.health
	self._health = data.health
	self._attack_power = data.attack_power
	self._attack_power = data.attack_range
	self._body.mesh = data.mesh


func _ready() -> void:
	self._health = self._max_health
