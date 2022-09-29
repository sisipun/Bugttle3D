extends KinematicBody


class_name Bug


export (NodePath) onready var _shape = get_node(_shape) as CollisionShape
export (NodePath) onready var _body = get_node(_body) as MeshInstance


var _max_health: int = 0
var _health: int = 0
var _attack_power: int = 0
var _attack_range: int = 0
var _team_id: int = 0


func init(team_id: int, data: BugData) -> void:
	self._team_id = team_id
	self._max_health = data.health
	self._health = data.health
	self._attack_power = data.attack_power
	self._attack_power = data.attack_range
	self._body.mesh = data.mesh
	self._body.translation = data.translation
	self._body.rotation_degrees = data.rotation_degrees
	self._body.scale = data.scale


func _ready() -> void:
	self._health = self._max_health
